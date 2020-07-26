defmodule Petro.Models.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  alias Petro.Models.Company

  schema "users" do
    many_to_many :companies, Company, join_through: "companies_users"

    pow_user_fields()
    timestamps()
  end
end
