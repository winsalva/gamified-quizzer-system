defmodule App.Repo.Migrations.DropAdmins do
  use Ecto.Migration

  def change do
    drop_if_exists table(:admins)
  end
end
