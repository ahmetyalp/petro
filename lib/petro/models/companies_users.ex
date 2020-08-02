defmodule Petro.Models.CompaniesUsers do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petro.Models.Company
  alias Petro.Models.User

  @user_roles ~w(user admin owner)

  schema "companies_users" do
    field :role, :string

    belongs_to :user, User
    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(companies_users, attrs) do
    companies_users
    |> cast(attrs, [:company_id, :user_id, :role])
    |> validate_required([:company_id, :user_id, :role])
    |> validate_inclusion(:role, @user_roles)
    |> unique_constraint([:company_id, :user_id])
  end
end
