defmodule Purlex.Data.Link do

  defstruct [
    :url_base, 
    :url_hash, 
    :url_host, 
    :ts_creation, 
    :ts_last_use, 
    :use_count
  ]

  alias Purlex.Data.Link

  @moduledoc """
  Manage links.

  We record a single record for each URL in the system.

  Payload elements:
  - url_base - the input url
  - url_hash - the url hash
  - url_host - the input url host
  - ts_creation - timestamp of the hash creation
  - ts_last_use - timestamp of last lookup
  - use_count - number of lookups

  The url_hash is used as the lookup key to retrieve the payload from the
  datastore.  
  """

  @doc """
  Create link payload, save in datastore, return the url_hash.
  """
  def create(url_base) do
    if valid_url?(url_base) do
      {:ok, create!(url_base)}
    else
      {:error, "Invalid URL"}
    end
  end

  @doc """
  Create link payload, save in datastore, return the url_hash.
  """
  def create!(url_base) do
    payload = create_payload(url_base)
    if has_key?(payload.url_hash) do
      payload.url_hash
    else
      save_payload(payload)
    end
  end

  @doc """
  Lookup the url_hash, update the use_count, return link payload.
  """
  def lookup(url_hash) do
    if has_key?(url_hash) do
      get_payload(url_hash)
      |> update_payload()
    else
      nil
    end
  end

  @doc """
  Return all records.
  """
  def all do
    sig()
    |> Pets.all()
  end

  def cleanup do
    sig()
    |> Pets.cleanup()
  end

  # ---------------

  defp create_payload(url_base) do
    key = hash(url_base)
    time_now = DateTime.utc_now()

    %Link{
      url_base: url_base,
      url_hash: key,
      url_host: URI.parse(url_base).host,
      ts_creation: time_now,
      ts_last_use: time_now,
      use_count: 0
    }
  end

  defp valid_url?(url) do
    Purlex.Url.regex()
    |> Regex.match?(url)
  end

  defp hash(string) do
    :md5
    |> :crypto.hash(string)
    |> Base.url_encode64(padding: false)
    |> String.slice(1..6)
  end

  defp has_key?(datakey) do
    sig()
    |> Pets.has_key?(datakey)
  end

  defp get_payload(datakey) do
    sig()
    |> Pets.lookup(datakey)
    |> List.first()
    |> elem(1)
  end

  defp save_payload(payload) do
    sig()
    |> Pets.insert({payload.url_hash, payload})
    payload.url_hash
  end

  defp update_payload(payload) do
    update =
      with date <- DateTime.utc_now(),
           count <- payload.use_count + 1,
           do: %Link{payload | ts_last_use: date, use_count: count}

    sig()
    |> Pets.insert({update.url_hash, update})
    update
  end

  @env Mix.env()
  defp sig do
    case @env do
      :dev  -> %{filepath: "/tmp/link_dev.dat", tablekey: :link_dev}
      :test -> %{filepath: "/tmp/link_test.dat", tablekey: :link_test}
      :prod -> %{filepath: "/tmp/link_prod.dat", tablekey: :link_prod}
    end
  end
end
