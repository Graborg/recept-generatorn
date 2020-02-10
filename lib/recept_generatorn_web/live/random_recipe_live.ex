defmodule ReceptGeneratornWeb.RandomRecipeLive do
  use Phoenix.LiveView
  alias ReceptGeneratorn.Recipe
  def mount(_session, socket) do
    {:ok, assign(socket, :name, Recipe.get_random_recipe() |> Map.get(:name))}
  end

  def render(assigns) do
    ReceptGeneratornWeb.PageView.render("random.html", assigns)
  end
end
