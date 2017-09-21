# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nu_mart,
  ecto_repos: [NuMart.Repo]

# Configures the endpoint
config :nu_mart, NuMartWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YD1J+94OEbwBN30DguF0ATWwVv6fNKy31oi5BPqNP1Yf3eSZN3hPA/o7dZ7Ze/Da",
  render_errors: [view: NuMartWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NuMart.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
