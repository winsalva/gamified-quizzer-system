defmodule App.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string, default: ""
      add :seen, :boolean, default: false
      add :subs_expire, :utc_datetime
      timestamps()
    end
  end
end
