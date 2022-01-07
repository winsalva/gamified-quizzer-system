defmodule AppWeb.AttendanceController do
  use AppWeb, :controller

  alias App.{Attendance, School}
  
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
	|> put_flash(:info, "Attendance added")
	|> redirect(to: Routes.attendance_path(conn, :show_student_attendance, id))
      {:error, %Ecto.Changeset{} = attendance} ->
        student = School.get_student!(id)
    attendances = Attendance.list_attendances_for_student(id)
        conn
	|> render("user-attendance.html", attendance: attendance, attendances: attendances, student: student)
    end
  end

  def index(conn, _params) do
    attendances = Attendance.list_attendances
    render(conn, :index, attendances: attendances)
  end
end
  
  