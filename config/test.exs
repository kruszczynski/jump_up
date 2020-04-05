import Config

config :jump_up, JumpUp.Repo,
  database: "jump_up_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
