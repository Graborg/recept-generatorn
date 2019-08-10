import Ecto.Query

defmodule ReceptGeneratornWeb.MainController do
  use ReceptGeneratornWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def getRecipe() do
    query =
      from ReceptGeneratorn.Recipe,
        order_by: fragment("RANDOM()"),
        limit: 1

    List.first(ReceptGeneratorn.Repo.all(query))

    # ReceptGeneratorn.Recipe
    # |> Ecto.Query.first()
    # |> ReceptGeneratorn.Repo.all()
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    # ReceptGeneratorn.Repo.delete_all(ReceptGeneratorn.Recipe)

    conn
    |> render("new.html")
  end

  def create(conn, params) do
    IO.inspect(params["main"]["name"])
    recept = %ReceptGeneratorn.Recipe{name: params["main"]["name"], ingredients: []}
    ReceptGeneratorn.Repo.insert(recept)

    conn
    |> render("new.html")
  end

  def random(conn, _params) do
    recipe = getRecipe()
    IO.inspect(recipe)

    conn
    |> assign(:name, recipe.name)
    |> render("random.html")
  end
end
