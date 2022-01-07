defmodule App.School.Attendance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attendances" do
    belongs_to :student, App.School.Student
    field :subject, :string
    field :session, :string
    field :date, :date
    field :status, :string
    field :time, :string
    timestamps()
  end


  @allowed_fields [
    :student_id,
    :subject,
    :session,
    :date,
    :status,
    :time
  ]

  def changeset(attendance, params \\ %{}) do
    attendance
    |> cast(params, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> assoc_constraint(:student)
  end
end