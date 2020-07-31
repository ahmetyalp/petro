defmodule PetroWeb.Plugs.FetchCurrentCompany do
  use PetroWeb, :controller

  alias Petro.Repo
  alias Petro.Models.Company

  def init(default), do: default

  def call(conn, preload) do
    company = case preload do
      nil -> Repo.get!(Company, conn.params["company_id"])
      _ -> Repo.get!(Company, conn.params["company_id"]) |> Repo.preload(preload)
    end

    conn
    |> assign(:current_company, company)

  rescue
    e in Ecto.NoResultsError ->
      IO.puts(inspect(e))
      conn |> redirect(to: Routes.dashboard_path(conn, :index)) |> halt()
  end
end
