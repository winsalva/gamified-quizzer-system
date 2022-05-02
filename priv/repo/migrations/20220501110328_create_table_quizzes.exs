defmodule App.Repo.Migrations.CreateTableQuizzes do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :level, :integer
      add :question, :text
      add :options, :text
      add :answer, :integer
      timestamps()
    end
  end
end
