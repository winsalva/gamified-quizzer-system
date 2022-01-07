defmodule AppWeb.PageController do
  use AppWeb, :controller
  
  def index(conn, _params) do
    #render(conn, :index)
    conn
    |> redirect(to: Routes.admin_session_path(conn, :new))
  end
end