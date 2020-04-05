import Config

config :jump_up, :megaboom, source_value: "foovalue"
config :jump_up, :megaboom, target_mac: "00:11:22:33:44:55"

config :jump_up, :player, music_dir: "music"

config :jump_up, :timer, schedule: [~T[06:45:00]]

config :logger, level: :info

config :jump_up, ecto_repos: [JumpUp.Repo]

config :jump_up, JumpUp.Repo,
  database: "jump_up",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

if Mix.env() == :test do
  config :logger, level: :error
  import_config("test.exs")
end

if Mix.env() == :prod do
  import_config("secret.exs")
end
