defmodule App.Repo.Migrations.AlterRandomPicsAddHasThumb do
  use Ecto.Migration

  def change do
    alter table(:random_pics) do
      add :has_thumb, :boolean, default: false
    end
  end
end
