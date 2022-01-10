defmodule App.School.Student do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.School.Attendance
  alias App.QuizAndExam.Quiz
  
  schema "students" do
    has_many :attendances, Attendance
    has_many :quizzes, Quiz
    field :firstname, :string
    field :lastname, :string

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:firstname, :lastname])
    |> validate_required([:firstname, :lastname])
  end
end
