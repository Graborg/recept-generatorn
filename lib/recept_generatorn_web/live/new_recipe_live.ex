defmodule ReceptGeneratornWeb.NewRecipeLive do
  use Phoenix.LiveView

  alias ReceptGeneratornWeb.Router.Helpers, as: Routes
  alias ReceptGeneratorn.Recipe

  def mount(session, socket) do
    recipes = Recipe.get_all_recipes()
    IO.inspect(socket, label: "mount")
    IO.inspect(session, label: "session mount")
    {:ok, assign(socket, recipes: recipes, username: nil, show_modal: false)}
  end

  def render(assigns) do
    ReceptGeneratornWeb.PageView.render("new.html", assigns)
  end

  def handle_event("add", %{"recipe" => %{"name" => name}}, socket) do
    # msg = %{ "body" => "your message" }
    # n = Pigeon.FCM.Notification.new("e1gqo-pka3zeHybk0DMPGD:APA91bG7qXWX5vxh4T2jFkVOB4XFRvFOPIWWO87bUaXbcMZTaiBGZwTgfNmTG0ZVa6D8lftmNIl5DA1QlsT3o7_WukxKpOmbqVBjzuJ_7pWTJYp4fG6dzehhfqWHVo3ZWgrl4bOZWfP0", msg)
    # IO.inspect(Pigeon.FCM.push(n))

    Recipe.create_recipe(name, [])
    recipes = Recipe.get_all_recipes()
    {:noreply, assign(socket, recipes: recipes)}
  end

  def handle_event(
        "add-ingredient",
        %{"recipe" => %{"ingredient" => ingredient, "recipe_name" => recipe_name}},
        socket
      ) do
    Recipe.add_ingredient(recipe_name, ingredient)
    recipes = Recipe.get_all_recipes()
    {:noreply, assign(socket, recipes: recipes)}
  end

  def handle_event("remove-recipe", %{"recipe" => recipe}, socket) do
    Recipe.remove_recipe(recipe)
    recipes = Recipe.get_all_recipes()
    {:noreply, assign(socket, recipes: recipes)}
  end

  def handle_event("remove-ingredient", %{"recipe" => recipe, "ingredient" => ingredient}, socket) do
    Recipe.remove_ingredient(recipe, ingredient)
    recipes = Recipe.get_all_recipes()
    {:noreply, assign(socket, recipes: recipes)}
  end

  def handle_info(
        {ReceptGeneratornWeb.LiveComponent.LoginModal, :login, %{username: username}},
        socket
      ) do
    IO.puts("patchin")

    {:noreply, assign(socket, username: username, show_modal: false)}
  end

  def handle_params(params, uri, socket) do
    handle_params(params, uri, last_path_segment(uri), socket)
  end

  def handle_params(_params, _uri, "open-login", socket) do
    {:noreply, assign(socket, show_modal: true)}
  end

  def handle_params(_params, _uri, "new", socket) do
    {:noreply, assign(socket, show_modal: false)}
  end

  defp last_path_segment(uri) do
    uri
    |> URI.parse()
    |> Map.get(:path)
    |> String.split("/", trim: true)
    |> List.last()
  end
end
