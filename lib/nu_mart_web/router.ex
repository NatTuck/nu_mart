defmodule NuMartWeb.Router do
  use NuMartWeb, :router
  import NuMartWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NavigationHistory.Tracker
    plug :fetch_user
    plug :fetch_cart
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NuMartWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/products", ProductController
    resources "/carts", CartController
    resources "/cart_items", CartItemController
    resources "/users", UserController
    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", NuMartWeb do
  #   pipe_through :api
  # end
end
