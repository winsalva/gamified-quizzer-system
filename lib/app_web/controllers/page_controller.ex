defmodule AppWeb.PageController do
  use AppWeb, :controller

  def fallback(conn, _params) do
    render(conn, "fallback.html")
  end
  
  def index(conn, _params) do
    render(conn, :index)
  end
end