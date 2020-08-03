defmodule PetroWeb.TeamController do
  use PetroWeb, :controller

  alias Petro.Models
  alias Petro.Models.Team
  alias Petro.Repo

  plug PetroWeb.Plugs.FetchCurrentCompany, :teams when action in [:index]
  plug PetroWeb.Plugs.FetchCurrentCompany when action not in [:index]
  plug :find_team when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    company = conn.assigns.current_company
    teams = company.teams
    render(conn, :index, teams: teams, company: company)
  end

  def new(conn, _params) do
    changeset = Models.change_team(%Team{})
    render(conn, :new, changeset: changeset, company: conn.assigns.current_company)
  end

  def create(conn, %{"team" => team_params}) do
    case Models.create_team(conn.assigns.current_company, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: Routes.team_path(conn, :show, conn.assigns.current_company, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, _) do
    team = conn.assigns.current_team
    render(conn, "show.html", team: team)
  end

  def edit(conn, _) do
    team = conn.assigns.current_team
    changeset = Models.change_team(team)
    render(conn, :edit, team: team, changeset: changeset, company: conn.assigns.current_company)
  end

  def update(conn, %{"team" => team_params}) do
    team = conn.assigns.current_team

    case Models.update_team(team, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: Routes.team_path(conn, :show, conn.assigns.current_company, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit,
          team: team,
          changeset: changeset,
          company: conn.assigns.current_company
        )
    end
  end

  def delete(conn, _) do
    team = conn.assigns.current_team
    {:ok, _team} = Models.delete_team(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: Routes.team_path(conn, :index, conn.assigns.current_company))
  end

  # private

  defp find_team(%Plug.Conn{} = conn, _) do
    team = Repo.get!(Team, conn.params["id"]) |> Repo.preload(:retros)

    if team.company_id == conn.assigns.current_company.id do
      conn |> assign(:current_team, team)
    else
      conn |> redirect(to: Routes.dashboard_path(conn, :index)) |> halt()
    end
  end
end
