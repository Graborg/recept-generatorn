defmodule ReceptGeneratornWeb.RandomRecipeLive do
  use Phoenix.LiveView
  alias ReceptGeneratorn.Recipe

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:username, nil)

    with %{name: name} <- Recipe.get_random_recipe() do
      {:ok, assign(socket, :name, name)}
    else
      nil -> {:ok, assign(socket, :name, nil)}
    end
  end

  def render(assigns) do
    ReceptGeneratornWeb.PageView.render("random.html", assigns)
  end
end
