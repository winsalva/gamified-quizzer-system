defmodule App.Schema.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    has_many :answers, App.Schema.Answer
    field :level, :integer
    field :question, :string
    field :options, :string
    field :answer, :integer
    timestamps()
  end

  @allowed_fields [
    :level,
    :question,
    :options,
    :answer
  ]

  @doc false
  def changeset(question, params \\ %{}) do
    question
    |> cast(params, @allowed_fields)
    |> validate_required(@allowed_fields)
  end
end