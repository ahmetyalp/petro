defmodule PetroWeb.CompanyController do
  use PetroWeb, :controller

  alias Petro.Models.Company
  alias Petro.Models.CompaniesUsers
  alias Petro.Repo

  plug PetroWeb.Plugs.FetchCurrentUser

  # company = %{company |  users: [conn.assigns.current_user]}
  def new(conn, _params) do
    changeset = Company.changeset(%Company{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case %Company{} |> Company.changeset(company_params) |> Repo.insert() do
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
    company = Company |> Repo.get!(id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Company |> Repo.get!(id)
    changeset = Company.changeset(company, %{})
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Company |> Repo.get!(id)

    case company
         |> Company.changeset(company_params)
         |> Repo.update() do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end
end
