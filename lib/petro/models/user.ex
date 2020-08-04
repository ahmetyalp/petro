defmodule Petro.Models.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  alias Petro.Models.{Company, Answer}

  schema "users" do
    many_to_many :companies, Company, join_through: "companies_users"

    has_many :answers, Answer

    pow_user_fields()
    timestamps()
  end
end
