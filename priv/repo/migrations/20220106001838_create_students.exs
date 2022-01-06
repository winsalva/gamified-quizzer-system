defmodule App.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :firstname, :string
      add :lastname, :string

      timestamps()
    end

  end
end
