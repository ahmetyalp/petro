defmodule PetroWeb.Plugs.CompanyUserChecker do
  use PetroWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias Petro.Repo
  alias Petro.Models.CompaniesUsers

  def init(default), do: default

  def call(conn, _) do
    user_role =
      Repo.one(
        from cu in CompaniesUsers,
          where:
            ^[company_id: conn.path_params["company_id"], user_id: Pow.current_user(conn).id],
          preload: [:company]
      )

    case user_role do
      nil ->
        conn
        |> redirect(to: Routes.dashboard_path(conn, :index))

      user_role ->
        conn
        |> assign(:user_role, user_role)
        |> assign(:current_company, user_role.company)
    end
  end
end
