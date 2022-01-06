defmodule AppWeb.SearchController do
  use AppWeb, :controller

  alias App.School
  
  def search_student(conn, %{"lastname" => lastname}) do
    query =
      case School.search_student(lastname) do
        [] -> []
	result -> result
      end

    conn
    |> redirect(to: Routes.quiz_path(conn, :index, query))
  end
end