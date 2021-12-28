defmodule AppWeb.Video.PageController do
  use AppWeb, :controller

  plug :ensure_logged_in
  plug :ensure_logged_in_admin when action in [
    :new, :create
  ]
  
  alias App.Query.Video
  
  def index(conn, _params) do
    videos = Video.list_videos()
    render(conn, :index, videos: videos)
  end

  def new(conn, _params) do
    video = Video.new_video()
    render(conn, :new, video: video)
  end
 
  def create(conn, %{"video" => params}) do
    admin_id = conn.assigns.current_admin.id
    params = Map.put(params, "admin_id", admin_id)
    case Video.insert_video(params) do
      {:ok, video} ->
        conn
	|> put_flash(:info, "New video uploaded successfully!")
	|> redirect(to: Routes.video_page_path(conn, :index))
      {:error, %Ecto.Changeset{} = video} ->
        conn
	|> render(:new, video: video)
    end
  end

  defp ensure_logged_in(conn, _options) do
    if conn.assigns.current_user && conn.assigns.current_user.subs_expire || conn.assigns.current_admin do
      conn
    else
      conn
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  defp ensure_logged_in_admin(conn, _options) do
    if conn.assigns.current_admin do
      conn
    else
      conn
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end