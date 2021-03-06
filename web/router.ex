defmodule Mandioca.Router do
  use Mandioca.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mandioca do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/apis", APIController, except: [:new, :edit]
    resources "/users", UserController

    get "/apis/:id/stats", APIController, :stats

    forward "/", Proxy
  end

  # Other scopes may use custom stacks.
  # scope "/api", Mandioca do
  #   pipe_through :api
  # end
end
