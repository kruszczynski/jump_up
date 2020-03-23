import Config

config :jump_up, :megaboom, source_value: "foovalue"
config :jump_up, :megaboom, target_mac: "00:11:22:33:44:55"

config :jump_up, :timer, schedule: [~T[06:45:00]]

config :logger, level: :info

if Mix.env() == :test do
  config :logger, level: :error
end

if Mix.env() == :prod do
  import_config("secret.exs")

  config :logger,
    backends: [{LoggerFileBackend, :error_log}]

  config :logger, :error_log,
    path: "log/app.log",
    level: :info
end
