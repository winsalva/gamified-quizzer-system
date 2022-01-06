defmodule App.Repo.Migrations.CreateQuizzes do
  use Ecto.Migration

  def change do
    create table(:quizzes) do
      add :date, :date
      add :subject, :string
      add :items, :integer
      add :score, :integer
      timestamps()
    end
  end
end
