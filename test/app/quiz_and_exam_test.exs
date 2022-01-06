defmodule App.QuizAndExamTest do
  use App.DataCase

  alias App.QuizAndExam

  describe "quizzes" do
    alias App.QuizAndExam.Quiz

    @valid_attrs %{items: 42, score: 42}
    @update_attrs %{items: 43, score: 43}
    @invalid_attrs %{items: nil, score: nil}

    def quiz_fixture(attrs \\ %{}) do
      {:ok, quiz} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QuizAndExam.create_quiz()

      quiz
    end

    test "list_quizzes/0 returns all quizzes" do
      quiz = quiz_fixture()
      assert QuizAndExam.list_quizzes() == [quiz]
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert QuizAndExam.get_quiz!(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      assert {:ok, %Quiz{} = quiz} = QuizAndExam.create_quiz(@valid_attrs)
      assert quiz.items == 42
      assert quiz.score == 42
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QuizAndExam.create_quiz(@invalid_attrs)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{} = quiz} = QuizAndExam.update_quiz(quiz, @update_attrs)
      assert quiz.items == 43
      assert quiz.score == 43
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = quiz_fixture()
      assert {:error, %Ecto.Changeset{}} = QuizAndExam.update_quiz(quiz, @invalid_attrs)
      assert quiz == QuizAndExam.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = QuizAndExam.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> QuizAndExam.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = QuizAndExam.change_quiz(quiz)
    end
  end
end
