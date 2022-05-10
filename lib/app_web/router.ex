defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AppWeb.Authenticator
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppWeb do
    pipe_through :browser

    # get "/*fallback", PageController, :fallback
    get "/", PageController, :index
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

  end

  scope "/users", AppWeb.User, as: :user do
    pipe_through :browser

    get "/lists/:title", PageController, :index
    post "/update/:id/:status", PageController, :update_approval
    get "/reset-records/:user_id", PageController, :reset_record
    resources "/", PageController, only: [
      :new, :create, :show, :edit, :update, :delete
    ]
  end

  scope "/questions", AppWeb.Question, as: :question do
    pipe_through :browser

    get "/lists/:level", PageController, :view_questions

    resources "/", PageController, only: [
      :new, :create, :show, :edit, :update, :delete
    ]
  end

  ## Quiz Routes ##
  scope "/quizzes", AppWeb.Quiz, as: :quiz do
    pipe_through :browser

    get "/new/:level", PageController, :new
    post "/", PageController, :create
    get "/player-rankings/:level", PageController, :view_ranking

  end

  # Other scopes may use custom stacks.
  # scope "/api", AppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AppWeb.Telemetry
    end
  end
end
