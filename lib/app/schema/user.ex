defmodule App.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    has_many :answers, App.Schema.Answer
    field :username, :string
    field :password, :string, default: ""
    field :role, :string
    field :school_id, :string
    field :current_score, :integer, default: 0
    field :approve, :boolean, default: false
    timestamps()
  end


  @allowed_fields [
    :username,
    :school_id,
    :password,
    :role,
    :current_score,
    :approve
  ]

  @doc false
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @allowed_fields)
    |> validate_required(@allowed_fields)
  end

  @doc false
  def changeset_with_password(user, params \\ %{}) do
    user
    |> cast(params, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 6)
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