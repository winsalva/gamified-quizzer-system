defmodule App.QuestionServer do
  use GenServer

  alias App.Query.Question


  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def get_questions(level) do
    GenServer.call(__MODULE__, {:level, level})
  end
    

  def init(state) do
    {:ok, state}
  end

  def handle_call({:level, level}, _from, state) do
  end
end