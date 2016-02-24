defmodule Estimator.Router do
  use Estimator.Web, :router

  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Estimator do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/stories", StoryController
  end

  scope "/auth", Estimator do
    pipe_through :browser # Use the default browser stack

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Estimator do
  #   pipe_through :api
  # end
end
