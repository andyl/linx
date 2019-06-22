defmodule PurlexWeb.Router do
  use PurlexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PurlexWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/urls", HomeController, :urls
    get "/logs", HomeController, :logs
    get "/stats", HomeController, :stats

    get "/page", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PurlexWeb do
  #   pipe_through :api
  # end
end
