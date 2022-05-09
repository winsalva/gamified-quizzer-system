defmodule AppWeb.Authenticator do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user =
      get_session(conn, :user_id)
      |> case do
        nil -> nil
        user_id -> App.Query.User.get_user(user_id)
      end

    cond do
      user != nil ->
        conn
        |> assign(:current_user, user)

      true ->
        conn
        |> assign(:current_user, nil)
    end
  end
end