defmodule AppWeb.Question.PageView do
  use AppWeb, :view

  def split_options(options) do
    [_|list] =
      String.trim(options)
      |> String.split("#")
    list
  end

end