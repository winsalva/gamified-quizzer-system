defmodule AppWeb.User.PageController do
  use AppWeb, :controller

  plug :ensure_admin_logged_in when action in [:index]
  
  alias App.Query.{User, Question, Answer}

  def reset_record(conn, %{"user_id" => user_id}) do
    User.reset_user_record(user_id)
    conn
    |> redirect(to: Routes.user_page_path(conn, :show, user_id))
  end

  def update_approval(conn, %{"id" => id, "status" => status}) do
    if status == "approved" do
      User.update_user(id, %{approve: false})
      conn
      |> redirect(to: Routes.user_page_path(conn, :index, "Approved"))
    else
      User.update_user(id, %{approve: true})
      conn
      |> redirect(to: Routes.user_page_path(conn, :index, "Unapproved"))
    end
  end

  def index(conn, %{"title" => title}) do
    if title == "Approved" do
      users = User.list_approved_users()
      render(conn, :index, users: users, title: title)
    else
      users = User.list_unapproved_users()
      render(conn, :index, users: users, title: title)
    end
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
    params = Map.put(params, "role", "user")
    case User.insert_user(params) do
      {:ok, user} ->
        conn
	|> put_flash(:info, "Welcome #{user.username}. Your account was created successfully! Please wait for admin approval.")
	|> redirect(to: Routes.page_path(conn, :index))
      {:error, %Ecto.Changeset{} = user} ->
        conn
	|> render("new.html", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User.get_user(id)
    if user.role == "admin" do
      approved_users = User.list_approved_users
      unapproved_users = User.list_unapproved_users
      level_1_questions = Question.list_level_1_questions
      level_2_questions = Question.list_level_2_questions
      level_3_questions = Question.list_level_3_questions
      params = [
        level_1_questions: level_1_questions,
	level_2_questions: level_2_questions,
	level_3_questions: level_3_questions,
        approved_users: approved_users,
	unapproved_users: unapproved_users,
	user: user
      ]
      render(conn, :show, params)
    else
      level_1_questions = Question.list_level_1_questions
      level_2_questions = Question.list_level_2_questions
      level_3_questions = Question.list_level_3_questions
      level_1_answers = Answer.list_user_answered_questions_on_level(user.id, 1)
      level_2_answers = Answer.list_user_answered_questions_on_level(user.id, 2)
      level_3_answers = Answer.list_user_answered_questions_on_level(user.id, 3)
      params = [
        level_1_questions: level_1_questions,
        level_1_answers: level_1_answers,
	level_2_questions: level_2_questions,
        level_2_answers: level_2_answers,
	level_3_questions: level_3_questions,
        level_3_answers: level_3_answers,
	user: user
      ]
      render(conn, :show, params)
    end
  end

  def delete(conn, %{"id" => id}) do
    User.delete_user(id)
    conn
    |> redirect(to: Routes.user_page_path(conn, :show, conn.assigns.current_user.id))
  end

  ## Ensure admin logged in
  defp ensure_admin_logged_in(conn, _options) do
    if conn.assigns.current_user && conn.assigns.current_user.role == "admin" do
      conn
    else
      conn
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end