defmodule App.Repo.Migrations.CreateAttendances do
  use Ecto.Migration

  def change do
    create table(:attendances) do
      add :student_id, references(:students, on_delete: :delete_all), null: false
      add :subject, :string
      add :session, :string
      add :date, :date
      add :status, :string
      add :time, :string
      timestamps()
    end
  end
end
