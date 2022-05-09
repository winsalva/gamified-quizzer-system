defmodule AppWeb.Question.PageController do
  use AppWeb, :controller

  alias App.Query.Question

  def view_questions(conn, %{"level" => level}) do
    case level do
      "level-1" ->
        questions = Question.list_level_1_questions
	conn
	|> render("view-questions.html", questions: questions)
      "level-2" ->
        questions = Question.list_level_2_questions
        conn
        |> render("view-questions.html", questions: questions)
      "level-3" ->
        questions = Question.list_level_3_questions
        conn
        |> render("view-questions.html", questions: questions)
    end
  end

  def new(conn, _params) do
    question = Question.new_question
    render(conn, :new, question: question)
  end

  def create(conn, %{"question" => params}) do
    case Question.insert_question(params) do
      {:ok, question} ->
        conn
	|> put_flash(:info, "New question added!")
	|> redirect(to: Routes.user_page_path(conn, :show, conn.assigns.current_user))
      {:error, %Ecto.Changeset{} = question} ->
        conn
	|> render(:new, question: question)
    end
  end

  def edit(conn, %{"id" => id}) do
    question = Question.edit_question(id)
    render(conn, :edit, question: question)
  end

  def update(conn, %{"question" => params, "id" => id}) do
    case Question.update_question(id, params) do
      {:ok, _question} ->
        conn
	|> redirect(to: Routes.user_page_path(conn, :show, conn.assigns.current_user.id))
      {:error, %Ecto.Changeset{} = question} ->
        conn
	|> render(:edit, question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    Question.delete_question(id)
    conn
    |> redirect(to: Routes.user_page_path(conn, :show, conn.assigns.current_user.id))
  end
end