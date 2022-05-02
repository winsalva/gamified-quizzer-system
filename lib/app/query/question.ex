defmodule App.Query.Question do
  @moduledoc """
  Documentation for Question
  """

  alias App.Repo
  alias App.Schema.Question

  @doc """
  New question.
  """
  def new_question do
    %Question{}
    |> Question.changeset()
  end

  @doc """
  Insert new question.
  """
  def insert_question(params) do
    %Question{}
    |> Question.changeset(params)
  end

  @doc """
  List questions..
  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Get question by id
  """
  def get_question(id) do
    Repo.get(Question, id)
  end

  @doc """
  Edit question
  """
  def edit_question(id) do
    get_question(id)
    |> Question.changeset()
  end

  @doc """
  Update question.
  """
  def update_question(id, params) do
    get_question(id)
    |> Question.changeset(params)
    |> Repo.update()
  end
end