defmodule ReceptGeneratornWeb.LiveComponent.LoginModal do
  use Phoenix.LiveComponent

  def render(assigns) do
    ReceptGeneratornWeb.PageView.render(
      "login_modal.html",
      assigns
    )
  end

  def mount(socket) do
    {:ok, assign(socket, conn: %Plug.Conn{})}
  end
end
