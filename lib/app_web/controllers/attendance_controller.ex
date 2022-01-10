defmodule AppWeb.AttendanceController do
  use AppWeb, :controller

  alias App.{Attendance, School}

  
  def search_student_attendance(conn, %{"lastname" => lastname}) do
    query =
      case School.search_student(lastname) do
        [] -> []
        result -> result
      end

    render(conn, "search-attendance.html", query: query, query_string: lastname)
  end

  def search_attendance(conn, _params) do
    render(conn, "search-attendance.html", query: nil)
  end

  def show_student_attendance(conn, %{"id" => id}) do
    student = School.get_student!(id)
    attendances = Attendance.list_attendances_for_student(id)
    attendance = Attendance.new_attendance()
    render(conn, "user-attendance.html", attendance: attendance, attendances: attendances, student: student)
  end

  def create_student_attendance(conn, %{"attendance" => params, "id" => id}) do
    params = Map.put(params, "student_id", id)
    case Attendance.insert_attendance(params) do
      {:ok, _attendance} ->
        conn
	|> put_flash(:info, "New attendance added.")
	|> redirect(to: Routes.attendance_path(conn, :show_student_attendance, id))
      {:error, %Ecto.Changeset{} = attendance} ->
        student = School.get_student!(id)
	params = [
	  student: student,
	  attendance: attendance
	]
        conn
	|> render("new-attendance.html", params)
    end
  end

  def index(conn, _params) do
    attendances = Attendance.list_attendances
    render(conn, :index, attendances: attendances)
  end

  def new_attendance(conn, %{"id" => id}) do
    student = School.get_student!(id)
    attendance = Attendance.new_attendance
    params = [
      student: student,
      attendance: attendance
    ]
    render(conn, "new-attendance.html", params)
  end
end
  
  