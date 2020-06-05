defmodule ReceptGeneratornWeb.Router do
  use ReceptGeneratornWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :fetch_user_token
    plug :put_secure_browser_headers
    plug :put_layout, {ReceptGeneratornWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  @spec fetch_user_token(Plug.Conn.t(), any) :: Plug.Conn.t()
  def fetch_user_token(conn, h) do
    conn
    |> assign(:user_token, get_session(conn, :username))
  end

  scope "/", ReceptGeneratornWeb do
    pipe_through :browser
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    live "/", RandomRecipeLive
    live "/new", NewRecipeLive
    live "/new/open-login", NewRecipeLive, as: "login_live"

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
