defmodule PetroWeb.CompanyController do
  use PetroWeb, :controller

  alias Petro.Models
  alias Petro.Models.Company
  alias Petro.Models.CompaniesUsers
  alias Petro.Repo

  def new(conn, _params) do
    changeset = Models.change_company(%Company{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
     case Repo.transaction(fn ->
      company = Models.create_company!(company_params)

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

  def show(conn, %{"company_id" => id}) do
    company = Models.get_company!(id)
    render(conn, :show, company: company)
  end

  def edit(conn, %{"company_id" => id}) do
    company = Models.get_company!(id)
    changeset = Models.change_company(company)
    render(conn, :edit, company: company, changeset: changeset)
  end

  def update(conn, %{"company_id" => id, "company" => company_params}) do
    company = Models.get_company!(id)

    case Models.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, company: company, changeset: changeset)
    end
  end
end
