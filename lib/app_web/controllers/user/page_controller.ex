defmodule AppWeb.User.PageController do
  use AppWeb, :controller

  plug :ensure_admin_logged_in when action in [:index, :show, :edit, :update]
  
  alias App.Query.User


  def index(conn, _params) do
    users = User.list_users()
    render(conn, :index, users: users)
  end

  def edit(conn, %{"id" => id}) do
    user = User.edit_user(id)
    render(conn, :edit, user: user)
  end

  def update(conn, %{"user" => params, "id" => id}) do
    case User.update_user(id, params) do
      {:ok, user} ->
        conn
	|> put_flash(:info, "User #{user.username} was updated successfully.")
	|> redirect(to: Routes.user_page_path(conn, :index))
      {:error, %Ecto.Changeset{} = user} ->
        conn
	|> render(:edit, user: user)
    end
  end

  def new(conn, _params) do
    user = User.new_user()
    render(conn, "new.html", user: user)
  end

  def create(conn, %{"user" => params}) do
    case User.insert_user(params) do
      {:ok, user} ->
        conn
	|> put_flash(:info, "Welcome #{user.username}. Your account was created successfully!")
	|> redirect(to: Routes.session_path(conn, :new))
      {:error, %Ecto.Changeset{} = user} ->
        conn
	|> render("new.html", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User.get_user(id)
    render(conn, :show, user: user)
  end

  ## Ensure admin logged in
  defp ensure_admin_logged_in(conn, _options) do
    if conn.assigns.current_admin do
      conn
    else
      conn
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end