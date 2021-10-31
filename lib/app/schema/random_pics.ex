defmodule App.Schema.RandomPics do
  use Ecto.Schema
  import Ecto.Changeset

  schema "random_pics" do
    field :file, :string
    field :thumbnail?, :boolean, source: :has_thumb
    timestamps()
  end

  def changeset(schema, params \\ %{}) do
    schema
    |> cast(params, [:file, :thumbnail?])
    |> validate_required([:file])
  end
end