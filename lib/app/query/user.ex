defmodule App.Query.User do
  alias App.Repo
  alias App.Schema.User

  import Ecto.Query, warn: false

  def new_user do
    %User{}
    |> User.changeset()
  end

  def insert_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def edit_user(id) do
    get_user(id)
    |> User.changeset()
  end

  def update_user(id, params) do
    get_user(id)
    |> User.changeset(params)
    |> Repo.update()
  end

  def get_username_and_password(username, password) do
    query =
      from u in User,
        where: u.username == ^username and u.password == ^password

    Repo.one(query)
  end
end