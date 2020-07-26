# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :petro,
  ecto_repos: [Petro.Repo]

# Configures the endpoint
config :petro, PetroWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nz4O98+43cRwtBQG53KNL/xjcXMQJy8pSy43/2mfEVI2B3o23BoSvUf7rNDlNFeE",
  render_errors: [view: PetroWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Petro.PubSub,
  live_view: [signing_salt: "bxwiofDo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :petro, :pow,
  user: Petro.Models.User,
  repo: Petro.Repo,
  cache_store_backend: PetroWeb.Pow.RedisCache,
  routes_backend: PetroWeb.Pow.Routes

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
