defmodule PetroWeb.Router do
  use PetroWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {PetroWeb.LayoutView, :root}
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :protect_company do
    plug PetroWeb.Plugs.CompanyUserChecker
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PetroWeb do
    pipe_through [:browser, :protected]

    get "/dashboard", DashboardController, :index
    resources "/", CompanyController, except: [:index, :delete]

    scope "/:company_id" do
      pipe_through :protect_company

      resources "/teams", TeamController
      resources "/retros", RetroController, except: [:index, :show]
      resources "/answers", AnswerController, only: [:update, :create, :delete]
      get "/retros/:id", RetroController, :live
    end
  end

  scope "/" do
    pipe_through :browser

    get "/", PetroWeb.WelcomeController, :index
    pow_routes()
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/admin" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PetroWeb.Telemetry
    end
  end
end
