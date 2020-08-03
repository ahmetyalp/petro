defmodule PetroWeb.RetroController do
  use PetroWeb, :controller

  alias Petro.Models
  alias Petro.Models.{Retro, Company, Team}
  alias Petro.Repo

  plug :find_retro when action not in [:new, :create]

  def new(conn, params) do
    changeset = Models.change_retro(%Retro{})

    render(conn, :new,
      changeset: changeset,
      action:
        Routes.retro_path(conn, :create, conn.assigns.current_company, team_id: params["team_id"])
    )
  end

  def create(conn, %{"retro" => retro_params, "team_id" => team_id}) do
    team = Repo.get!(Team, team_id) |> Repo.preload(:company)
    company_id = conn.assigns.current_company.id
    %Company{id: ^company_id} = team.company

    retro =
      Ecto.build_assoc(
        team,
        :retros
      )
      |> Retro.changeset(retro_params)

    case Repo.insert(retro) do
      {:ok, retro} ->
        conn
        |> put_flash(:info, "Retro created successfully.")
        |> redirect(
          to:
            Routes.retro_path(
              conn,
              :show,
              conn.assigns.current_company,
              retro
            )
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show)
  end

  def edit(conn, %{"id" => id}) do
    retro = conn.assigns.retro
    changeset = Models.change_retro(retro)
    render(conn, :edit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "retro" => retro_params}) do
    retro = conn.assigns.retro

    case Models.update_retro(retro, retro_params) do
      {:ok, retro} ->
        conn
        |> put_flash(:info, "Retro updated successfully.")
        |> assign(:retro, retro)
        |> redirect(
          to:
            Routes.retro_path(
              conn,
              :show,
              conn.assigns.current_company,
              retro
            )
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    retro = conn.assigns.retro
    {:ok, _retro} = Models.delete_retro(retro)

    conn
    |> put_flash(:info, "Retro deleted successfully.")
    |> assign(:retro, nil)
    |> redirect(
      to:
        Routes.team_path(
          conn,
          :show,
          conn.assigns.current_company,
          retro.team
        )
    )
  end

  defp find_retro(conn, _params) do
    retro = Retro.get!(conn.path_params["id"], preload: :company)

    cond do
      retro.company.id == conn.assigns.current_company.id ->
        conn |> assign(:retro, retro)

      true ->
        conn |> redirect(to: Routes.dashboard_path(conn, :index)) |> halt()
    end
  end
end
