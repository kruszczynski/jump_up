import Config

config :jump_up, :megaboom, source_value: "foovalue"
config :jump_up, :megaboom, target_mac: "00:11:22:33:44:55"

if Mix.env() == :prod, do: import_config("secret.exs")
