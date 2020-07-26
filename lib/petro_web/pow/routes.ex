defmodule PetroWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias PetroWeb.Router.Helpers, as: Routes

  @impl true
  def after_sign_in_path(conn), do: Routes.dashboard_path(conn, :index)

  @impl true
  def after_sign_out_path(conn), do: Routes.welcome_path(conn, :index)
end
