defmodule AppWeb.Quiz.PageController do
  use AppWeb, :controller

  plug :ensure_user_logged_in

  alias App.Query.{Answer, Question, User}

  def view_ranking(conn, %{"level" => level}) do
    {level, _} = Integer.parse(level)
    if conn.assigns.current_user.role == "user" do
      case level do
        1 ->
	  accounts = Answer.list_user_rankings_per_level(level)
	  params = [
	    accounts: accounts,
	    title: "My Account"
	  ]
	  render(conn, "view-ranking.html", params)
	2 ->
          accounts = Answer.list_user_rankings_per_level(level)
          params = [
            accounts: accounts,
            title: "My Account"
          ]
          render(conn, "level2-ranking.html", params)
	3 ->
          accounts = Answer.list_user_rankings_per_level(level)
          params = [
            accounts: accounts,
            title: "My Account"
          ]
          render(conn, "level3-ranking.html", params)
	4 ->
          accounts = User.list_winners()
          params = [
            accounts: accounts,
            title: "My Account"
          ]
          render(conn, "winner-ranking.html", params)
	end
    else
      case level do
        1 ->
          accounts = Answer.list_user_rankings_per_level(level)
          params = [
            accounts: accounts,
            title: "Admin Dashboard"
          ]
          render(conn, "view-ranking.html", params)
	2 ->
          accounts = Answer.list_user_rankings_per_level(level)
          params = [
            accounts: accounts,
            title: "Admin Dashboard"
          ]
          render(conn, "level2-ranking.html", params)
	3 ->
          accounts = Answer.list_user_rankings_per_level(level)
          params = [
            accounts: accounts,
            title: "Admin Dashboard"
          ]
          render(conn, "level3-ranking.html", params)
	4 ->
          accounts = User.list_winners()
          params = [
            accounts: accounts,
            title: "Admin Dashboard"
          ]
          render(conn, "winner-ranking.html", params)
      end
    end
  end

  def new(conn, %{"level" => level}) do
    {game_level, _} = Integer.parse(level)
    user_id = conn.assigns.current_user.id
    questions = Question.list_unanswered_questions_of_user_by_level(user_id, level) 
    if questions != [] do
      [question|_] = questions
      answer = Answer.new_answer()
      params = [
        level: level,
        question: question,
	answer: answer
      ]
      render(conn, :new, params)
    else
      cond do
        game_level == 1 ->
	  User.update_user(user_id, %{level_1: true})
	game_level == 2 ->
	  User.update_user(user_id, %{level_2: true})
	game_level == 3 ->
	  User.update_user(user_id, %{level_3: true})
	true ->
      end
      conn
      |> redirect(to: Routes.user_page_path(conn, :show, user_id))
    end
  end

  def create(conn, %{"answer" => %{"answer" => answer}, "question_id" => question_id, "level" => level}) do
    user = conn.assigns.current_user
    question = Question.get_question(question_id)
    {ans, _} = Integer.parse(answer)
    {game_level, _} = Integer.parse(level)

    multiplier =
    if game_level == 2 || game_level == 3 do
      Enum.random(1..3)
    else
      1
    end

    bonus =
    if game_level == 3 do
      Enum.random([1000, 5000, 10000])
    else
      0
    end
    
    is_correct =
    if question.answer == ans do
        true
    else
        false
    end

    point =
      cond do
        is_correct && game_level == 1 ->
	  Enum.random(1000..10000)
	is_correct && game_level == 2 ->
	  Enum.random(1000..10000) * multiplier
	is_correct && game_level == 3 ->
	  Enum.random(1000..10000) * multiplier + bonus
	!is_correct && game_level == 3 ->
	  -(Enum.random(1000..10000) * multiplier + bonus)
	true ->
	  0
      end
      
    current_score = user.current_score + point
 
    params = %{
      user_id: user.id,
      question_id: question.id,
      level: game_level,
      answer: ans,
      is_correct: is_correct,
      point: point,
      current_score: current_score,
      multiplier: multiplier,
      bonus: bonus
    }

    User.update_user(user.id, %{current_score: current_score})

    case Answer.insert_answer(params) do
      {:ok, _answer} ->
        conn
	|> redirect(to: Routes.quiz_page_path(conn, :new, level))
      {:error, %Ecto.Changeset{} = answer} ->
        
        question = Question.get_question(question_id)
	params = [
	  level: level,
	  question: question,
	  answer: answer
	]
	render(conn, :new, params)
    end
  end


  # ensure user logged in
  defp ensure_user_logged_in(conn, _options) do
    if conn.assigns.current_user != nil do
      conn
    else
      conn
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end