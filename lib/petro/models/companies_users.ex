defmodule Petro.Models.CompaniesUsers do
  use Ecto.Schema
  import Ecto.Changeset

  @user_roles ~w(user admin owner)

  schema "companies_users" do
    field :company_id, :integer
    field :user_id, :integer
    field :role, :string

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
