defmodule App.Repo.Migrations.CreateRandomPics do
  use Ecto.Migration

  def change do
    create table(:random_pics) do
      add :file, :string
      timestamps()
    end
  end
end
