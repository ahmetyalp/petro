defmodule PetroWeb.Plugs.CompanyUserChecker do
  use PetroWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias Petro.Repo
  alias Petro.Models.CompaniesUsers

  def init(default), do: default

  def call(conn, _) do
    case Repo.all(
      from cu in CompaniesUsers,
        where: ^[company_id: conn.path_params["company_id"], user_id: Pow.current_user(conn).id]
    ) do
      [head | _ ] ->
        conn
        |> assign(:user_role, head)
      _ ->
        conn
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end
end
