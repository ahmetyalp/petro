defmodule PetroWeb.CompanyController do
  use PetroWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias Petro.Models
  alias Petro.Models.{Company, CompaniesUsers}
  alias Petro.Repo

  plug :control_access when action in [:edit, :update]

  def new(conn, _params) do
    changeset = Company.change(%Company{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case Repo.transaction(fn ->
           company = Company.create!(company_params)

           %CompaniesUsers{}
           |> CompaniesUsers.changeset(%{
             company_id: company.id,
             user_id: conn.assigns.current_user.id,
             role: "owner"
           })
           |> Repo.insert!()

           company
         end) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, err} ->
        IO.puts(inspect(err))

        conn
        |> put_flash(:info, "Company can not created")
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    redirect(conn, to: Routes.team_path(conn, :index, id))
  end

  def edit(conn, %{"id" => id}) do
    company = Company.get!(id)
    changeset = Company.change(company)
    render(conn, :edit, company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Company.get!(id)

    case Models.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, company: company, changeset: changeset)
    end
  end

  defp control_access(conn, _opts) do
    case Repo.one(
           from cu in CompaniesUsers,
             where: ^[company_id: conn.path_params["id"], user_id: Pow.current_user(conn).id]
         ) do
      %CompaniesUsers{role: "owner"} ->
        conn

      _ ->
        conn
        |> redirect(to: Routes.dashboard_path(conn, :index))
        |> halt()
    end
  end
end
