defmodule App.Repo.Migrations.AlterUsersAddLevels do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :level_1, :boolean, default: false
      add :level_2, :boolean, default: false
      add :level_3, :boolean, default: false
    end

    create unique_index(:users, [:school_id])
  end
end
