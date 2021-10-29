defmodule App.Schema.RandomPics do
  use Ecto.Schema
  import Ecto.Changeset

  schema "random_pics" do
    field :file, :string
    timestamps()
  end

  def changeset(schema, params \\ %{}) do
    schema
    |> cast(params, [:file])
    |> validate_required([:file])
  end
end