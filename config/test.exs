import Config

config :jump_up, :megaboom, source_value: "foovalue"
config :jump_up, :megaboom, target_mac: "00:11:22:33:44:55"

config :jump_up, :player, music_dir: "music"

config :jump_up, JumpUp.Repo,
  database: "jump_up_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
