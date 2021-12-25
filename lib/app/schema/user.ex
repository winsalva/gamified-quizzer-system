defmodule App.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string, default: ""
    field :seen, :boolean, default: false
    field :subs_expire, :utc_datetime
    timestamps()
  end


  @allowed_fields [
    :username,
    :password,
    :seen,
    :subs_expire
  ]

  @required_fields [
    :username
  ]

  @doc false
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end

  @doc false
  def changeset_with_password(user, params \\ %{}) do
    user
    |> cast(params, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 8)
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