defmodule App.Repo.Migrations.DropTables do
  use Ecto.Migration

  def change do
    drop_if_exists table(:attendances)
    drop_if_exists table(:videos)
    drop_if_exists table(:quizzes)
    drop_if_exists table(:students)
  end
end
