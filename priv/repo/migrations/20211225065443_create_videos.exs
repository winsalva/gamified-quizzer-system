defmodule App.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :admin_id, references(:admins, on_delete: :delete_all), null: false
      add :title, :string
      add :description, :text
      timestamps()
    end
  end
end
