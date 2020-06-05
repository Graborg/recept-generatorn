defmodule ReceptGeneratornWeb.SessionController do
  use ReceptGeneratornWeb, :controller

  def create(conn, %{"session" => %{"username" => username}}) do
    conn
    |> put_session(:username, username)
    |> redirect(to: "/")
  end
end
