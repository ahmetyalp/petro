defmodule PetroWeb.CompanyController do
  use PetroWeb, :controller

  alias Petro.Models
  alias Petro.Models.Company
  alias Petro.Models.CompaniesUsers
  alias Petro.Repo

  def new(conn, _params) do
    changeset = Models.change_company(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case Models.create_company(company_params) do
      {:ok, company} ->
        %CompaniesUsers{company_id: company.id, user_id: conn.assigns.current_user.id}
        |> Repo.insert!()

        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Models.get_company!(id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Models.get_company!(id)
    changeset = Models.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Models.get_company!(id)

    case Models.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end
end
