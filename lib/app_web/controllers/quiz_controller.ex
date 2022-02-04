defmodule AppWeb.QuizController do
  use AppWeb, :controller

  alias App.QuizAndExam
  alias App.QuizAndExam.Quiz
  alias App.School

  def quiz_result(conn, %{"id" => id}) do
    quizzes = QuizAndExam.list_student_quiz_records(id)
    student = School.get_student!(id)
    total_average = QuizAndExam.get_student_quiz_total_average(id)
    render(conn, "quiz-result.html", quizzes: quizzes, student: student, total_average: total_average)
  end

  def search_student(conn, %{"lastname" => lastname}) do
    query =
      case School.search_student(lastname) do
        [] -> []
        result -> result
      end

    render(conn, :index, query: query, query_string: lastname)
  end

  def index(conn, _params) do
    render(conn, "index.html", query: nil)
  end

  def new(conn, %{"student_id" => student_id}) do
    student = School.get_student!(student_id)
    changeset = QuizAndExam.change_quiz(%Quiz{})
    render(conn, "new.html", changeset: changeset, student: student)
  end

  def create(conn, %{"quiz" => quiz_params, "student_id" => student_id}) do
    student = School.get_student!(student_id)
    params = Map.put(quiz_params, "student_id", student_id)
    case QuizAndExam.create_quiz(params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz points for #{student.firstname} was added successfully.")
        |> redirect(to: Routes.student_path(conn, :show, student_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = QuizAndExam.get_quiz!(id)
    render(conn, "show.html", quiz: quiz)
  end

  def edit(conn, %{"id" => id}) do
    quiz = QuizAndExam.get_quiz!(id)
    changeset = QuizAndExam.change_quiz(quiz)
    render(conn, "edit.html", quiz: quiz, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quiz" => quiz_params}) do
    quiz = QuizAndExam.get_quiz!(id)

    case QuizAndExam.update_quiz(quiz, quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz updated successfully.")
        |> redirect(to: Routes.quiz_path(conn, :show, quiz))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quiz: quiz, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz = QuizAndExam.get_quiz!(id)
    {:ok, _quiz} = QuizAndExam.delete_quiz(quiz)

    conn
    |> put_flash(:info, "Quiz deleted successfully.")
    |> redirect(to: Routes.quiz_path(conn, :index))
  end
end
