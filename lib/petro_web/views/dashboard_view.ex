defmodule PetroWeb.DashboardView do
  use PetroWeb, :view
  alias Petro.Repo
  alias Petro.Models.User

  def current_user(conn) do
    user_id = Pow.current_user(conn).id

    Repo.get!(User, user_id) |> Repo.preload(:companies)
  end
end
