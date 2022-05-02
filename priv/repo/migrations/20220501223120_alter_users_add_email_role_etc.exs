defmodule App.Repo.Migrations.AlterUsersAddEmailRoleEtc do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string
      add :school_id, :string
      add :current_score, :integer
      add :approve, :boolean, default: false
      remove :seen
      remove :subs_expire
    end
  end
end
