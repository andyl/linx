defmodule Linx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def init(arg) do
    # IO.inspect "+++++++++++++++++++++++++++++++++++++++"
    # IO.inspect "LINX INIT"
    # IO.inspect arg
    # IO.inspect "+++++++++++++++++++++++++++++++++++++++"
    {:ok, arg}
  end

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Linx.Repo,
      # Start the Telemetry supervisor
      LinxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Linx.PubSub},
      # Start the Endpoint (http/https)
      LinxWeb.Endpoint
      # Start a worker by calling: Linx.Worker.start_link(arg)
      # {Linx.Worker, arg}
    ]

    # IO.inspect "---------------------------------------"
    # IO.inspect "STARTING LINKEX APP"
    # IO.inspect Application.get_all_env(:linx)
    # IO.inspect "---------------------------------------"

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
