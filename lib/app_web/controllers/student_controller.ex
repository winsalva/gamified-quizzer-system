defmodule AppWeb.StudentController do
  use AppWeb, :controller

  alias App.School
  alias App.QuizAndExam
  alias App.School.Student

  def index(conn, _params) do
    students = School.list_students()
    render(conn, "index.html", students: students)
  end

  def new(conn, _params) do
    changeset = School.change_student(%Student{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    case School.create_student(student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: Routes.student_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = School.get_student!(id)
    quizzes = QuizAndExam.list_student_quiz_records(id)
    render(conn, "show.html", student: student, quizzes: quizzes)
  end

  def edit(conn, %{"id" => id}) do
    student = School.get_student!(id)
    changeset = School.change_student(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = School.get_student!(id)

    case School.update_student(student, student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student record updated successfully.")
        |> redirect(to: Routes.student_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = School.get_student!(id)
    {:ok, _student} = School.delete_student(student)

    conn
    |> put_flash(:info, "Student record was deleted successfully.")
    |> redirect(to: Routes.student_path(conn, :index))
  end
end
