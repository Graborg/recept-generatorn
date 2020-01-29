defmodule ReceptGeneratornWeb.LiveView do
  use Phoenix.LiveView
  alias ReceptGeneratorn.Recipe
  def mount(_session, socket) do
    recipes = Recipe.get_all_recipes()
    {:ok, assign(socket, recipes: recipes)}
  end

  def render(assigns) do
    ReceptGeneratornWeb.PageView.render("new.html", assigns)
  end

  def handle_event("add", %{"recipe" => %{"name" => name}}, socket) do
    Recipe.create_recipe(name, [])
    recipes = Recipe.get_all_recipes()
    {:noreply, assign(socket, recipes: recipes)}
  end

  def handle_event("add-ingredient", %{"recipe" => %{"ingredient" => ingredient, "recipe_name" => recipe_name }}, socket) do
    Recipe.add_ingredient(recipe_name, ingredient)
    recipes = Recipe.get_all_recipes()
    {:noreply, assign(socket, recipes: recipes)}
  end
end
