defmodule App.Schema.Video do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Schema.Admin
  
  schema "videos" do
    belongs_to :admin, Admin
    field :title, :string
    field :description, :string
    timestamps()
  end

  @allowed_fields [
    :admin_id,
    :title,
    :description
  ]

  @required_fields [
    :admin_id,
    :title,
    :description
  ]

  @doc false
  def changeset(video, params \\ %{}) do
    video
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:admin)
  end
end