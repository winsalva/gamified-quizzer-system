defmodule App.Repo.Migrations.AlterQuizzes do
  use Ecto.Migration

  def change do
    alter table(:quizzes) do
      add :student_id, references(:students, on_delete: :delete_all), null: false
    end
  end
end
