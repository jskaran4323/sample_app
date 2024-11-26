defmodule SampleAppWeb.Router do
  use SampleAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug SampleAppWeb.Plugs.FetchCurrentUser
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SampleAppWeb do
    pipe_through :browser

    get("/", StaticPageController, :home, as: :root)



    get("/help", StaticPageController, :help, as: :help)
    get("/about", StaticPageController, :about, as: :about)
    get("/contact", StaticPageController, :contact, as: :contact)
    get("/signup", UserController,:new, as: :signup)
    post("/signup", UserController,:create, as: :signup)
    get("/login", SessionController, :new,as: :login)

    post("/login", SessionController, :create,as: :login)

    get "/logout", SessionController, :delete

    resources "/users", UserController, only: [:index, :show, :edit, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SampleAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:sample_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SampleAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
