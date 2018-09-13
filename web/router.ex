defmodule SimpleChat.Router do
  use SimpleChat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SimpleChat.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SimpleChat do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/rooms", RoomController, :index
    get "/rooms/new", RoomController, :new
    get "/rooms/:id", RoomController, :get_one
    post "/rooms", RoomController, :create
  end
  
  scope "/auth", SimpleChat do
    pipe_through :browser
    
    get "/logout", AuthController, :logout

    # Ueberauth provides the request fn
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

end
