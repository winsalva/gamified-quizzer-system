defmodule App.Attendance do
  alias App.Repo
  alias App.School.Attendance


  import Ecto.Query, warn: false


  def new_attendance do
    %Attendance{}
    |> Attendance.changeset()
  end

  def insert_attendance(params) do
    %Attendance{}
    |> Attendance.changeset(params)
    |> Repo.insert()
  end

  def list_attendances_for_student(id) do
    query =
      from a in Attendance,
        where: a.student_id == ^id,
	order_by: [desc: :inserted_at]

    Repo.all(query)
  end

  def list_attendances do
    query =
      from a in Attendance,
        preload: [:student]

    Repo.all(query)
  end
end