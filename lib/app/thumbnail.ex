defmodule App.Thumbnail do

  alias App.RandomPicsUploads
  alias App.Schema.RandomPics

  @doc """
  Setting up thumbnail path.
  """
  def thumbnail_path(id, filename) do
    [RandomPicsUploads.uploads_dir(), "thumb-#{id}-#{filename}.jpg"]
    |> Path.join()
  end

  def mogrify_thumbnail(src_path, dst_path) do
    Mogrify.open(src_path)
    |> Mogrify.resize_to_fill("851x315")
    |> Mogrify.save(path: dst_path)
  end

  @doc """
  Create thumbnails.
  """
  def create_thumbnail(upload) do
    original_path = RandomPicsUploads.local_path(0, upload.file)
    thumb_path = thumbnail_path(0, upload.file)
    case mogrify_thumbnail(original_path, thumb_path) do
      %Mogrify.Image{} = image ->
        App.Query.RandomPics.update_random_pics(upload, %{thumbnail?: true})
      {:error, :invalid_src_path} -> IO.puts "Invalid src path."
      {:error, error} -> IO.inspect error
    end
  end

  def create_thumbnail(upload) do
    RandomPics.changeset(upload, %{})
  end
end