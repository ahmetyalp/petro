defmodule Petro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Petro.Repo,
      # Start the Telemetry supervisor
      PetroWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Petro.PubSub},
      # Start the Endpoint (http/https)
      PetroWeb.Endpoint,
      # Start a worker by calling: Petro.Worker.start_link(arg)
      # {Petro.Worker, arg}
      {Redix, name: :redix}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Petro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PetroWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
