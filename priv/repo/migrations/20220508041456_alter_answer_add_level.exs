defmodule App.Repo.Migrations.AlterAnswerAddLevel do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      add :level, :integer
    end
  end
end
