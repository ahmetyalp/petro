defmodule Petro.Models.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petro.Models.User
  alias Petro.Models.Retro

  @types ~w(positive negative neutral)

  schema "answers" do
    field :details, :string
    field :type, :string
    field :is_visible, :boolean
    field :auto_visible, :boolean

    belongs_to :user, User
    belongs_to :retro, Retro

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:type, :details])
    |> validate_required([:type, :details])
    |> validate_inclusion(:type, @types)
  end
end
