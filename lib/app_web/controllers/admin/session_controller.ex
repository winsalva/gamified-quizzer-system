defmodule AppWeb.Admin.SessionController do
  use AppWeb, :controller

  alias App.Query.Admin
  
  def new(conn, _params) do
    if Admin.list_admins() == [] do
      params = %{
        username: "Superadmin",
	email: "superadmin@gmail.com",
	password: "superadmin",
	password_confirmation: "superadmin",
	super_admin: true
      }
      Admin.insert_admin(params)
      render(conn, :new)
    else
      render(conn, :new)
    end
  end

  def create(conn, %{"email" => email, "password" => password}) do
      case Admin.get_admin_by_email_and_password(email, password) do
        %App.Schema.Admin{} = admin ->
          conn
          |> put_session(:user_id, nil)
          |> put_session(:admin_id, admin.id)
          |> configure_session(renew: true)
          |> redirect(to: Routes.student_path(conn, :index))
        false ->
          conn
          |> put_flash(:error, "Username and password combination cannot be found!")
          |> render("new.html")
      end
    end
end