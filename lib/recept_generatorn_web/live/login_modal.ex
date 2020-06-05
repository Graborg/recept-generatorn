defmodule ReceptGeneratornWeb.LiveComponent.LoginModal do
  use Phoenix.LiveComponent

  def render(assigns) do
    ReceptGeneratornWeb.PageView.render(
      "login_modal.html",
      assigns
    )
  end

  def handle_event("login", %{"user" => %{"username" => username}}, socket) do
    IO.inspect(socket, label: "socket")

    send(
      self(),
      {__MODULE__, :login, %{username: username}}
    )

    {:noreply, socket}
  end

  def mount(socket) do
    {:ok, assign(socket, conn: %Plug.Conn{})}
  end

  def update(%{id: _id} = assigns, socket) do
    {:ok, assign(socket, assigns)}
  end
end
