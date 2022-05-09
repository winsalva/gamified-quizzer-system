defmodule App.Schema.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    belongs_to :user, App.Schema.User
    belongs_to :question, App.Schema.Question
    field :level, :integer
    field :answer, :integer
    field :is_correct, :boolean
    field :point, :integer
    field :current_score, :integer
    field :multiplier, :integer, default: 1
    field :bonus, :integer, default: 0
    timestamps()
  end

  @allowed_fields [
    :user_id,
    :question_id,
    :level,
    :answer,
    :is_correct,
    :point,
    :current_score,
    :multiplier,
    :bonus
  ]

  @doc false
  def changeset(answer, params \\ %{}) do
    answer
    |> cast(params, @allowed_fields)
    |> validate_required(@allowed_fields)
  end
end