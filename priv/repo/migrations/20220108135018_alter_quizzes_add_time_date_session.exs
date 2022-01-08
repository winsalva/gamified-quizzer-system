defmodule App.Repo.Migrations.AlterQuizzesAddTimeDateSession do
  use Ecto.Migration

  def change do
    alter table(:quizzes) do
      add :time, :string
      add :session, :string
    end
  end
end
