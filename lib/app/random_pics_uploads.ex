defmodule App.RandomPicsUploads do

  def uploads_dir do
    Application.get_env(:app, :uploads_dir)
  end

  @doc """
  Setting the application upload's local path.
  """
  def local_path(user_id, filename) do
    [uploads_dir(), "#{user_id}-#{filename}"]
    |> Path.join()
  end
end