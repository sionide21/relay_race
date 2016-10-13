# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :nerves, :firmware, rootfs_additions: "rootfs-additions"

# List the GPIO pin numbers that are attached to relays
config :relay, :pins, [5, 6, 13, 19, 26, 17, 27, 22]

# Use the real relay code when on the device
config :fw, :relay_supervisor, Relays.RelaySupervisor
config :fw, :relay, Relays.Relay

# Configure phoenix for the web_interface
config :web_interface, WebInterface.Endpoint,
  http: [port: 80],
  url: [host: "localhost", port: 80],
  secret_key_base: "5iLBsYekUPbil5DdTmQuet6P8C9RmOhXVVl83J9SW/jCwjH67msd3toYfKFWoqjQ",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Nerves.PubSub]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"
import_config "wifi.exs"
