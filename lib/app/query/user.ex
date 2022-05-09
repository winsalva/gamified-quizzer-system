defmodule App.Query.User do
  alias App.Repo
  alias App.Schema.{User, Answer}

  import Ecto.Query, warn: false

  @doc """
  Reset user records.
  """
  def reset_user_record(user_id) do
    params = %{
      current_score: 0,
      level_1: false,
      level_2: false,
      level_3: false
    }
    update_user(user_id, params)

    query =
      from a in Answer,
        where: a.user_id == ^user_id

    Repo.delete_all(query)
  end

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

  @doc """
  List approved users.
  """
  def list_approved_users do
    query =
      from u in User,
        where: u.approve == true and u.role != "admin"

    Repo.all(query)
  end

  @doc """
  List unapproved users.
  """
  def list_unapproved_users do
    query =
      from u in User,
        where: u.approve == false

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

  def get_school_id_and_password(school_id, password) do
    query =
      from u in User,
        where: u.school_id == ^school_id and u.password == ^password

    Repo.one(query)
  end
end