defmodule Purlex.Data.GenStore do

  @moduledoc "A generic data-store using PersistentEts."

  @doc "Start the data-store with tablekey and filepath."
  def start(tablekey, filepath, opts \\ []) do
    if started?(tablekey), do: stop(tablekey)
    tableopts = Enum.uniq([:named_table, :public] ++ opts)
    PersistentEts.new(tablekey, filepath, tableopts)
  end

  @doc "Stop the data-store and remove the data-file."
  def stop(tablekey, filepath) do
    stop(tablekey)
    File.rm(filepath)
  end

  @doc "Stop the data-store."
  def stop(tablekey) do
    if started?(tablekey), do: PersistentEts.delete(tablekey)
  end

  @doc """
  Insert a tuple into the data-store.

  The datakey is the first element in the tuple.
  """
  def insert(tablekey, tuple) do
    :ets.insert(tablekey, tuple)
  end

  @doc """
  Lookup a datakey in the datastore.
  
  The datakey is the first element in the tuple.
  """
  def lookup(tablekey, datakey) do
    :ets.lookup(tablekey, datakey)
  end

  # @doc "Check for existence of key in data-store".
  def has_key?(tablekey, datakey) do
    :ets.lookup(tablekey, datakey) != []
  end

  @doc "Return true if a table has been started."
  def started?(tablekey) do
    :ets.whereis(tablekey) != :undefined
  end

  @doc "Generate a test context."
  def test_context do
    with num <- Enum.random(10000..99999),
         do: %{
           tablekey: String.to_atom("link_#{num}"),
           filepath: "/tmp/store_test_#{num}.dat"
         }
  end
end
