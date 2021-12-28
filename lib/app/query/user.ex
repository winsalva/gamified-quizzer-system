defmodule App.Query.User do
  alias App.Repo
  alias App.Schema.User

  import Ecto.Query, warn: false

  @doc """
  Checks for pass expiration on users table periodically.
  """
  def check_pass_expire() do
    utc_now = DateTime.utc_now
    query =
      from u in User,
        where: not is_nil(u.subs_expire)

    result = Repo.all(query)

    if result == [] do
      result
    else
      result
      |> Enum.filter(fn x ->
        if DateTime.compare(x.subs_expire, utc_now) == :lt do
          x
        end
      end)
      |> Enum.map(fn x -> update_user(x.id, %{subs_expire: nil, password: ""}) end)
    end
  end

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
    query =
      from u in User,
        order_by: [desc: :updated_at]

    Repo.all(query)
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