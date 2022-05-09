defmodule App.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    has_many :answers, App.Schema.Answer
    field :username, :string
    field :password, :string, default: ""
    field :hashed_password, :string
    field :role, :string
    field :school_id, :string
    field :current_score, :integer, default: 0
    field :approve, :boolean, default: false
    field :level_1, :boolean, default: false
    field :level_2, :boolean, default: false
    field :level_3, :boolean, default: false
    timestamps()
  end


  @allowed_fields [
    :username,
    :school_id,
    :hashed_password,
    :password,
    :role,
    :current_score,
    :approve,
    :level_1,
    :level_2,
    :level_3
  ]

  @doc false
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> unique_constraint(:school_id)
  end

  @doc false
  def changeset_with_password(user, params \\ %{}) do
    user
    |> cast(params, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 4)
    |> validate_length(:password, max: 20)
    |> validate_confirmation(:password, required: true)
    |> hash_password()
    |> changeset(params)
  end

  defp hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:hashed_password, App.Password.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end