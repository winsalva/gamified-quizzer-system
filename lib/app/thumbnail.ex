defmodule App.Thumbnail do

  alias App.RandomPicsUploads
  alias App.Schema.RandomPics

  @doc """
  Setting up thumbnail path.
  """
  def thumbnail_path(id) do
    [RandomPicsUploads.uploads_dir(), "thumb-#{id}.jpg"]
    |> Path.join()
  end

  def mogrify_thumbnail(src_path, dst_path) do
    try do
      Mogrify.open(src_path)
      |> Mogrify.resize_to_limit("300x300")
      |> Mogrify.save(path: dst_path)
    rescue
      File.Error -> {:error, :invalid_src_path}
      error -> {:error, error}
    else
      _image -> {:ok, dst_path}
    end
  end

  @doc """
  Create thumbnails.
  """
  def create_thumbnail(%Plug.Upload{content_type: "image/" <> _image_type} = upload) do
    original_path = RandomPicsUploads.local_path(0, upload.filename)
    thumb_path = thumbnail_path(1)
    {:ok, _} = mogrify_thumbnail(original_path, thumb_path)
    RandomPics.changeset(upload, %{thumbnail?: true})
  end

  def create_thumbnail(upload) do
    RandomPics.changeset(upload, %{})
  end
end