defmodule AppWeb.PageController do
  use AppWeb, :controller
  
  def index(conn, _params) do
    #render(conn, :index)
    conn
    |> redirect(to: Routes.student_path(conn, :index))
  end
end