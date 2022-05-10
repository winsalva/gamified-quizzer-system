defmodule App.Query.Answer do
  @moduledoc """
  Documentation for Answer
  """

  alias App.Repo
  alias App.Schema.Answer
  import Ecto.Query, warn: false

  @doc """
  Get all user rankings by level.
  """
  def list_user_rankings_per_level(level) do
    query1 =
      from a in Answer,
        where: a.level == ^level

    Repo.all(query1)
    |> Enum.reduce([], fn f, acc -> [f.user_id|acc] end)
    |> Enum.uniq()
    |> Enum.map(fn f -> get_user_points_per_level(f, level) end)
    |> Enum.sort_by(&Map.fetch(&1, :current_score), :desc)
  end

  def get_user_points_per_level(user_id, level) do
    query =
      from a in Answer,
        where: a.user_id == ^user_id and a.level == ^level,
	order_by: [desc: :inserted_at],
	preload: [:user]

    [user|_] = Repo.all(query)

    user
  end

  @doc """
  List user answered question based on level
  """
  def list_user_answered_questions_on_level(user_id, level) do
    query =
      from a in Answer,
        where: a.user_id == ^user_id and a.level == ^level

    Repo.all(query)
  end
    

  @doc """
  New answer.
  """
  def new_answer do
    %Answer{}
    |> Answer.changeset()
  end

  @doc """
  Insert answer
  """
  def insert_answer(params) do
    %Answer{}
    |> Answer.changeset(params)
    |> Repo.insert()
  end

  @doc """
  List answers
  """
  def list_answers do
    Repo.all(Answer)
  end

  @doc """
  Get answer by id
  """
  def get_answer(id) do
    Repo.get(Answer, id)
  end

  @doc """
  Edit answer.
  """
  def edit_answer(id) do
    get_answer(id)
    |> Answer.changeset()
  end

  @doc """
  Update answer.
  """
  def update_answer(id, params) do
    get_answer(id)
    |> Answer.changeset(params)
    |> Repo.update()
  end
end