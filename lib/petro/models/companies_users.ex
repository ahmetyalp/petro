defmodule Petro.Models.CompaniesUsers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies_users" do
    field :company_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(companies_users, attrs) do
    companies_users
    |> cast(attrs, [:company_id, :user_id])
    |> validate_required([:company_id, :user_id])
    |> unique_constraint([:company_id, :user_id])
  end
end
