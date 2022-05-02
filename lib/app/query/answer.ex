defmodule App.Query.Answer do
  @moduledoc """
  Documentation for Answer
  """

  alias App.Repo
  alias App.Schema.Answer

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