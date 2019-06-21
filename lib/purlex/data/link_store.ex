defmodule Purlex.Data.LinkStore do
  use GenServer

  alias Purlex.Data.GenStore

  @moduledoc "A data-store for links."

  @tablekey :links
  @filepath "/tmp/linkstore.dat"

  @doc "For calling at startup time."
  def start_link(data \\ []), do: GenServer.start_link(__MODULE__, data)

  @doc "Start the linkstore."
  def init(data \\ []) do
    start()
    {:ok, data}
  end

  @doc "Start the linkstore using default tablekey and filepath."
  def start, do: start(@tablekey, @filepath)

  @doc "Start the linkstore with explicit tablekey and filepath."
  def start(sym, path), do: GenStore.start(sym, path)

  @doc "Insert a tuple into the default data-store."
  def insert(tuple), do: insert(@tablekey, tuple)

  @doc "Insert a tuple into a specific data-store."
  def insert(sym, tuple), do: GenStore.insert(sym, tuple)

  @doc "Lookup tuple from default data-store."
  def lookup(key), do: lookup(@tablekey, key)

  @doc "Lookup tuple from specific data-store."
  def lookup(sym, key), do: GenStore.lookup(sym, key)
end
