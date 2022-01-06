defmodule App.School.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :firstname, :string
    field :lastname, :string

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:firstname, :lastname])
    |> validate_required([:firstname, :lastname])
  end
end
