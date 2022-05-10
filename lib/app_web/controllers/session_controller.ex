defmodule AppWeb.SessionController do
  use AppWeb, :controller

  alias App.Query.User
  
  def new(conn, _params) do
    user = User.get_user_by(%{school_id: "sysadmin"})
    if user == nil do
      user = %{
        school_id: "sysadmin",
	username: "Admin",
	password: "sysadmin",
	password_confirmation: "sysadmin",
	approve: true,
	role: "admin"
      }
      User.insert_user(user)
      render(conn, "new.html")
    else
      render(conn, "new.html")
    end
  end

  def create(conn, %{"school_id" => school_id, "password" => password}) do
    if password == "" do
      conn
      |> put_flash(:error, "Password can't be empty!")
      |> render("new.html")
    else
      case User.get_school_id_and_password(school_id, password) do
        %App.Schema.User{} = user ->
	  if user.role == "user" do
	    conn
	    |> put_session(:user_id, user.id)
	    |> configure_session(renew: true)
	    |> redirect(to: Routes.user_page_path(conn, :show, user.id))
	  else
	    conn
	    |> put_session(:user_id, user.id)
	    |> configure_session(renew: true)
	    |> redirect(to: Routes.quiz_page_path(conn, :view_ranking, 1))
	  end
	nil ->
	  conn
	  |> put_flash(:error, "School Id and password combination cannot be found!")
	  |> render("new.html")
      end
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> redirect(to: Routes.page_path(conn, :index))
  end
end