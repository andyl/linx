defmodule Purlex.Data.LogStore do
  use GenServer

  @basepath "ets"
  @tablesym :logs
  @filepath "logstore.dat"

  def start_link(data \\ []) do
    GenServer.start_link(__MODULE__, data)
  end

  def init(data \\ []) do
    start()
    # IO.puts("------------------------------")
    # IO.puts("STARTING LOGSTORE (#{result})")
    # IO.puts("------------------------------")
    {:ok, data}
  end

  def start do
    unless File.dir?(@basepath), do: File.mkdir(@basepath)
    PersistentEts.new(@tablesym, @filepath, [:named_table, :public])
  end

  def insert(tuple) do
    :ets.insert(@tablesym, tuple)
  end

  def lookup(key) do
    :ets.lookup(@tablesym, key)
  end
end
