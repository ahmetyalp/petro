defmodule PetroWeb.DashboardController do
  use PetroWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
