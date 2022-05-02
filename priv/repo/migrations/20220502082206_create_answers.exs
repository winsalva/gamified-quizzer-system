defmodule App.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :question_id, references(:questions, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :answer, :integer
      add :is_correct, :boolean
      add :point, :integer
      add :current_score, :integer
      add :multiplier, :integer
      add :bonus, :integer
      timestamps()
    end
  end
end
