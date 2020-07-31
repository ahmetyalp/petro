defmodule PetroWeb.WelcomeController do
  use PetroWeb, :controller

  def index(conn, _params) do
    case Pow.current_user(conn) do
      nil ->
        render(conn, :index)
      _ ->
        conn
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end
end
