defmodule ReceptGeneratornWeb.Router do
  use ReceptGeneratornWeb, :router
  # use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_layout, {ReceptGeneratornWeb.LayoutView, :app}
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReceptGeneratornWeb do

    # pipe_through :browser
    live "/new", LiveView
    # get "/", MainController, :random
    # # get "/new", MainController, :new
    # post "/new", MainController, :create
    # delete "/:id", MainController, :delete
    # get "/random", MainController, :random
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReceptGeneratornWeb do
  #   pipe_through :api
  # end
end
