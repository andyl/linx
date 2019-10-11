defmodule LinxWeb.Router do
  use LinxWeb, :router

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

  scope "/", LinxWeb do
    pipe_through :browser

    get "/",      HomeController, :index
    get "/urls",  HomeController, :urls
    get "/logs",  HomeController, :logs
    get "/stats", HomeController, :stats
    # get "/:key",  HomeController, :key_direct

    live "/demo", Demo
  end

  scope "/api", LinxWeb do
    pipe_through :api
  end
end
