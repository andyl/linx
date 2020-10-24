defmodule Linx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  use GenServer

  def init(arg) do
    IO.inspect "+++++++++++++++++++++++++++++++++++++++"
    IO.inspect "LINKEX INIT"
    IO.inspect arg
    IO.inspect "+++++++++++++++++++++++++++++++++++++++"
    {:ok, arg}
  end

  def start_link(args) do
    IO.inspect "#######################################"
    IO.inspect "LINKEX START_LINK"
    IO.inspect args
    IO.inspect "#######################################"
    GenServer.start_link(__MODULE__, args)
  end

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      LinxWeb.Endpoint
      # Starts a worker by calling: Linx.Worker.start_link(arg)
      # {Linx.Worker, arg},
    ]

    IO.inspect "---------------------------------------"
    IO.inspect "STARTING LINKEX APP"
    IO.inspect Application.get_all_env(:linx)
    IO.inspect "---------------------------------------"
    
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Linx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LinxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
