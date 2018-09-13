# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :simple_chat,
  ecto_repos: [SimpleChat.Repo]

# Configures the endpoint
config :simple_chat, SimpleChat.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YRy/oKEJBDJ2phHGKfb9TZvx6psfcNYkq6SNzMsz3RLRSd2c9oQ8+ZRn6ctNGksZ",
  render_errors: [view: SimpleChat.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SimpleChat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure OAuth
config :ueberauth, Ueberauth,
  providers: [
    # facebook: { Ueberauth.Strategy.Facebook, [] },
    google: { Ueberauth.Strategy.Google, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
