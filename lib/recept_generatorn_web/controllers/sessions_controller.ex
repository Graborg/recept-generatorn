defmodule ReceptGeneratornWeb.SessionController do
  use ReceptGeneratornWeb, :controller

  def create(conn, %{"session" => %{"username" => username}}) do
    user_id =
      case ReceptGeneratorn.Accounts.get_user_by_username!(username) do
        nil -> ReceptGeneratorn.Accounts.create_user(%{username: username})
        user -> user
      end
      |> Map.get(:id)

    conn
    |> put_session(:user_id, user_id)
    |> redirect(to: "/")
  end
end
