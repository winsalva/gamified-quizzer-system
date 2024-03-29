# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configure mogrify command
#config :mogrify, mogrify_command: [
 # path: "magick",
 # args: ["mogrify"]
#]

# Configure convert command:
#config :mogrify, convert_command: [
#  path: "magick",
#  args: ["convert"]
#]

# Configure identify command:
#config :mogrify, identify_command: [
#  path: "magick",
#  args: ["identify"]
#]

config :app,
  ecto_repos: [App.Repo]

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0jhFAIW9SCglrPsLnAzk9UULbLI6Pvzj3tsoUrIaJ4Fwx7UZYsfhEYWiKWC/OTV0",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: App.PubSub,
  live_view: [signing_salt: "PFkKQ/cK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
