defmodule App.Query.Video do
  alias App.Repo
  alias App.Schema.Video


  def new_video do
    %Video{}
    |> Video.changeset()
  end

  def insert_video(params) do
    %Video{}
    |> Video.changeset(params)
    |> Repo.insert()
  end

  def list_videos do
    Repo.all(Video)
  end

  def get_video(id) do
    Repo.get(Video, id)
  end

  def edit_video(id) do
    get_video(id)
    |> Video.changeset()
  end

  def update_video(id, params) do
    get_video(id)
    |> Video.changeset(params)
    |> Repo.update()
  end

  def delete_video(id) do
    get_video(id)
    |> Repo.delete()
  end
end