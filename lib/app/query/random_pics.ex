defmodule App.Query.RandomPics do
  @moduledoc """
  RandomPics module documentation.
  """

  alias App.Repo
  alias App.Schema.RandomPics
  alias App.RandomPicsUploads

  @doc """
  New random pic.
  """
  def new_random_pics do
    RandomPics.changeset(%RandomPics{})
  end

  @doc """
  Insert new random pic.
  """
  def insert_random_pics(params) do
    %RandomPics{}
    |> RandomPics.changeset(params)
    |> Repo.insert()
  end

  def insert_random_pics(file, user_id, params) do
    Repo.transaction(fn ->
      with {:ok, upload} <- insert_random_pics(params),
      :ok <- File.cp(file.path, RandomPicsUploads.local_path(user_id, file.filename)
             ) do
        {:ok, upload}
      else
        {:error, reason} -> Repo.rollback(reason)
      end
    end)
  end

  @doc """
  List random pics.
  """
  def list_random_pics do
    Repo.all(RandomPics)
  end

  @doc """
  Get random pic by id.
  """
  def get_random_pics(id) do
    Repo.get(RandomPics, id)
  end
end