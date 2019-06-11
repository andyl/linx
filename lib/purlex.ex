defmodule Purlex do
  @moduledoc """
  Purlex keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  use Application

  def start(_type, _args) do
    children = [
      PurlexWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Purlex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    PurlexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
