defmodule PetroWeb.DashboardView do
  use PetroWeb, :view
  alias Petro.Repo

  def current_user(conn) do
    Pow.current_user(conn) |> Repo.preload(:companies)
  end
end
