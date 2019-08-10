defmodule ReceptGeneratornWeb.PageController do
  use ReceptGeneratornWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
