defmodule ReceptGeneratornWeb.RandomRecipeLive do
  use Phoenix.LiveView
  alias ReceptGeneratorn.Recipe

  def mount(_session, socket) do
    recipe = Recipe.get_random_recipe()
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
    {:ok, assign(socket, name: recipe.name)}
  end

  def render(assigns) do
    ReceptGeneratornWeb.PageView.render("random.html", assigns)
  end
end
