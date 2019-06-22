defmodule PurlexWeb.Router do
  use PurlexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PurlexWeb do
    pipe_through :browser
    live "/", CounterLive

    # get "/", HomeController, :index
    get "/urls", HomeController, :urls
    get "/logs", HomeController, :logs
    get "/stats", HomeController, :stats
  end

  scope "/api", PurlexWeb do
    pipe_through :api
  end
end
