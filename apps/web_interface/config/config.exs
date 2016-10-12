# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Use fake FW modules when developing
config :fw, :relay_supervisor, FakeFw.RelaySupervisor
config :fw, :relay, FakeFw.Relay

# Configures the endpoint
config :web_interface, WebInterface.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5iLBsYekUPbil5DdTmQuet6P8C9RmOhXVVl83J9SW/jCwjH67msd3toYfKFWoqjQ",
  render_errors: [view: WebInterface.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebInterface.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
