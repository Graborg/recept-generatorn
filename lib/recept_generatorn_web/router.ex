defmodule ReceptGeneratornWeb.Router do
  use ReceptGeneratornWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :fetch_username
    plug :put_secure_browser_headers
    plug :put_layout, {ReceptGeneratornWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  def fetch_username(conn, _) do
    conn
    |> assign(:username, get_session(conn, :username))
  end

  scope "/", ReceptGeneratornWeb do
    pipe_through :browser
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    live "/", RandomRecipeLive
    live "/new", NewRecipeLive
    live "/new/open-login", NewRecipeLive, as: "login_live"

    # delete "/:id", MainController, :delete
  end
end
