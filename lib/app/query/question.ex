defmodule App.Query.Question do
  @moduledoc """
  Documentation for Question
  """

  alias App.Repo
  alias App.Schema.{Question, Answer}
  import Ecto.Query, warn: false

  def list_unanswered_questions_of_user_by_level(user_id, level) do
    answered_questions =
      from a in Answer,
        where: a.user_id == ^user_id and a.level == ^level,
	select: a.question_id

    answered = Repo.all(answered_questions)
	
    query =
      from q in Question,
        where: q.level == ^level and q.id not in ^answered

    Repo.all(query)
    |> Enum.shuffle()
  end

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
    |> Repo.insert()
  end

  @doc """
  List questions..
  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  List level 1 questions.
  """
  def list_level_1_questions do
    query =
      from q in Question,
        where: q.level == 1

    Repo.all(query)
  end

  @doc """
  List level 2 questions.
  """
  def list_level_2_questions do
    query =
      from q in Question,
        where: q.level == 2

    Repo.all(query)
  end

  @doc """
  List level 3 questions.
  """
  def list_level_3_questions do
    query =
      from q in Question,
        where: q.level == 3

    Repo.all(query)
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

  @doc """
  Deletes a question by its id.
  """
  def delete_question(id) do
    get_question(id)
    |> Repo.delete()
  end
end