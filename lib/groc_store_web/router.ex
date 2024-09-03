defmodule GrocStoreWeb.Router do
  use GrocStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GrocStoreWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GrocStoreWeb do
    pipe_through :browser

    get "/", HomeController, :home
    # get "/customers", CustomerController, :index
    # get "/customers/:id", CustomerController, :show
    resources "/customers", CustomerController
  end

  # Other scopes may use custom stacks.
  scope "/api", GrocStoreWeb do
    pipe_through :api

    #### customer apis
    post "/customers", CustomerController, :create_customer
    get "/customers", CustomerController, :index
    get "/customers/:id", CustomerController, :show


  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:groc_store, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GrocStoreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
