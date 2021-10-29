defmodule AppWeb.RandomPicsController do
  use AppWeb, :controller


  alias App.Query.RandomPics
  
  def new(conn, _params) do
    random_pic = RandomPics.new_random_pics()
    render(conn, :new, random_pic: random_pic)
  end

  def create(conn, %{"random_pics" => %{"file" => file}}) do
    params = %{"file" => file.filename}
    case RandomPics.insert_random_pics(file, 0, params) do
      {:ok, _random_pic} ->
        conn
	|> redirect(to: Routes.random_pics_path(conn, :index))
      {:error, %Ecto.Changeset{} = random_pic} ->
        render(conn, :new, random_pic: random_pic)
    end
  end

  def create(conn, _params) do
    random_pic = RandomPics.new_random_pics()
    conn
    |> put_flash(:error, "Select an image.")
    |> render(:new, random_pic: random_pic)
  end

  def index(conn, _params) do
    random_pics = RandomPics.list_random_pics()
    render(conn, :index, random_pics: random_pics)
  end
end