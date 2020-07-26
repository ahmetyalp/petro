defmodule PetroWeb.Plugs.FetchCurrentUser do
  import Plug.Conn

  alias Petro.Repo
  alias Pow.Plug, as: Pow
  alias Petro.Models.User

  def init(default), do: default

  def call(conn, _params) do
    conn |> assign(:current_user, Repo.get!(User, Pow.current_user(conn).id))
  end
end
