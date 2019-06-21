defmodule Purlex.Data.GenStore do

  @moduledoc "A generic data-store using PersistentEts."

  @doc "Start the data-store with tablekey and filepath."
  def start(tablekey, filepath) do
    if started?(tablekey), do: stop(tablekey)
    PersistentEts.new(tablekey, filepath, [:named_table, :public])
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

  @doc "Insert a tuple into the data-store."
  def insert(tablekey, tuple) do
    :ets.insert(tablekey, tuple)
  end

  @doc "Lookup a key in the datastore"
  def lookup(tablekey, key) do
    :ets.lookup(tablekey, key)
  end

  @doc "Return true if a table has been started."
  def started?(tablekey) do
    :ets.whereis(tablekey) != :undefined
  end
end
