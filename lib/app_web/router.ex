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

    get "/", PageController, :index
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

  end

  scope "/schools", AppWeb do
    pipe_through :browser

    resources "/students", StudentController
    resources "/quiz-and-exam", QuizController
    post "/search", QuizController, :search_student
    get "/quiz-results/:id", QuizController, :quiz_result
   
  end

  scope "/school", AppWeb do
    pipe_through :browser

    get "/students/attendances/:id", AttendanceController, :show_student_attendance
    post "/students/attendances", AttendanceController, :create_student_attendance
    get "/students/attendances", AttendanceController, :index
  end

  scope "/users", AppWeb.User, as: :user do
    pipe_through :browser

    resources "/", PageController, only: [
      :new, :create, :show, :index, :edit, :update
    ]
  end

  scope "/videos", AppWeb.Video, as: :video do
    pipe_through :browser

    resources "/", PageController, only: [
      :index, :new, :create, :edit, :update, :delete
    ]

  end

  scope "/admins", AppWeb.Admin, as: :admin do
    pipe_through :browser

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    resources "/", PageController, only: [
      :index, :new, :create, :show, :edit, :update, :delete
    ]

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
