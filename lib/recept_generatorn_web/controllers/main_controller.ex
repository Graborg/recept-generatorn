import Ecto.Query

defmodule ReceptGeneratornWeb.MainController do
  use ReceptGeneratornWeb, :controller
  alias ReceptGeneratorn.Recipe

  def index(conn, _params) do
    render(conn, :index)
  end

  def getRecipe() do
    query =
      from ReceptGeneratorn.Recipe,
        order_by: fragment("RANDOM()"),
        limit: 1

    List.first(ReceptGeneratorn.Repo.all(query))
  end

  def create(conn, params) do
    IO.puts("inspector")
    IO.inspect(params["main"]["name"])
    recept = %ReceptGeneratorn.Recipe{name: params["main"]["name"], ingredients: []}
    ReceptGeneratorn.Repo.insert(recept)
    recipes = Recipe.get_all_recipes()

    conn
    |> assign(:name, recipes)
    |> assign(:recipes, recipes)
    |> render("new.html")
  end

  def delete(conn, %{"id" => id}) do
    ReceptGeneratorn.Recipe
    |> ReceptGeneratorn.Repo.get!(id)
    |> ReceptGeneratorn.Repo.delete!()

    conn
    |> redirect(to: "/new")
  end

  def random(conn, _params) do
    conn
    |> assign(:username, nil)
    |> render("random.html")

    # case getRecipe() do
    #   nil ->
    #     conn
    #     |> put_flash(:info, "You need to first create a recipe")
    #     |> redirect( to: "/new")
    #   recipe ->
    #     conn
    #     |> assign(:name, recipe.name)
    #     |> render("random.html")
    # end
  end
end
