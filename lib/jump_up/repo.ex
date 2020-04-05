defmodule JumpUp.Repo do
  use Ecto.Repo,
    otp_app: :jump_up,
    adapter: Ecto.Adapters.Postgres
end
