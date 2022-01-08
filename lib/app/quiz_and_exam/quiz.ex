defmodule App.QuizAndExam.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quizzes" do
    belongs_to :student, App.School.Student
    field :date, :date
    field :time, :string
    field :session, :string
    field :subject, :string
    field :items, :integer
    field :score, :integer

    timestamps()
  end

  @allowed_fields [
    :student_id,
    :date,
    :time,
    :session,
    :subject,
    :items,
    :score
  ]

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> assoc_constraint(:student)
  end
end
