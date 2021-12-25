defmodule AppWeb.User.PageController do
  use AppWeb, :controller

  alias App.Query.User

  def new(conn, _params) do
    user = User.new_user()
    render(conn, "new.html", user: user)
  end

  def create(conn, %{"user" => params}) do
    case User.insert_user(params) do
      {:ok, user} ->
        conn
	|> redirect(to: Routes.user_page_path(conn, :show, user.id))
      {:error, %Ecto.Changeset{} = user} ->
        conn
	|> render("new.html", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User.get_user(id)
    render(conn, :show, user: user)
  end
end