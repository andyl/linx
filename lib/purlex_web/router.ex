defmodule PurlexWeb.Router do
  use PurlexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PurlexWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PurlexWeb do
    pipe_through :browser

    get "/", PageController, :index
    # get "/users", UserController, :index
    # get "/users/:id", UserController, :show
    # resources "/users", UserController, only: [:index, :show, :new, :create]
    # resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PurlexWeb do
  #   pipe_through :api
  # end
end
