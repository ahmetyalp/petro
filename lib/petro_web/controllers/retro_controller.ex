defmodule PetroWeb.RetroController do
  use PetroWeb, :controller

  alias Petro.Models
  alias Petro.Models.Retro
  alias Petro.Repo
  alias Petro.Models.Team

  plug :find_team

  def index(conn, _params) do
    retros = Retro.all(conn.assigns.current_team)
    render(conn, "index.html", retros: retros)
  end

  def new(conn, _params) do
    changeset = Models.change_retro(%Retro{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"retro" => retro_params}) do
    retro =
      Ecto.build_assoc(
        conn.assigns.current_team,
        :retros
      )
      |> Retro.changeset(retro_params)

    case Repo.insert(retro) do
      {:ok, retro} ->
        conn
        |> put_flash(:info, "Retro created successfully.")
        |> redirect(
          to:
            Routes.team_retro_path(
              conn,
              :show,
              conn.assigns.current_company,
              conn.assigns.current_team,
              retro
            )
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    retro = Models.get_retro!(id)
    render(conn, "show.html", retro: retro)
  end

  def edit(conn, %{"id" => id}) do
    retro = Models.get_retro!(id)
    changeset = Models.change_retro(retro)
    render(conn, "edit.html", retro: retro, changeset: changeset)
  end

  def update(conn, %{"id" => id, "retro" => retro_params}) do
    retro = Models.get_retro!(id)

    case Models.update_retro(retro, retro_params) do
      {:ok, retro} ->
        conn
        |> put_flash(:info, "Retro updated successfully.")
        |> redirect(
          to:
            Routes.team_retro_path(
              conn,
              :show,
              conn.assigns.current_company,
              conn.assigns.current_team,
              retro
            )
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", retro: retro, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    retro = Models.get_retro!(id)
    {:ok, _retro} = Models.delete_retro(retro)

    conn
    |> put_flash(:info, "Retro deleted successfully.")
    |> redirect(
      to:
        Routes.team_retro_path(
          conn,
          :index,
          conn.assigns.current_company,
          conn.assigns.current_team
        )
    )
  end

  defp find_team(conn, _params) do
    case Repo.get(Team, conn.path_params["team_id"]) do
      nil ->
        conn |> redirect(to: Routes.dashboard_path(conn, :index)) |> halt()

      team ->
        conn |> assign(:current_team, team)
    end
  end
end
