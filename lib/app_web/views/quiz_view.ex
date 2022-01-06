defmodule AppWeb.QuizView do
  use AppWeb, :view

  def result(quiz) do
    quiz.score / quiz.items * 100
  end

  def status(quiz) do
    result = quiz.score / quiz.items * 100
    if result >= 75 do
      "Passed"
    else
      "Failed"
    end
  end
end
