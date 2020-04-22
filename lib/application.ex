defmodule JumpUp do
  @moduledoc """
  Documentation for JumpUp.
  """
  use Application
  require Logger
  alias JumpUp.{Repo, Timer}
  alias JumpUp.WakeUp.Player

  @version Mix.Project.config()[:version]

  def start(_type, _args) do
    children = [
      Repo,
      %{
        id: Timer,
        start: {Timer, :start_link, []}
      },
      %{
        id: Player,
        start: {Player, :start_link, []}
      }
    ]

    Logger.info("Starting JumpUp v#{@version}")
    # Now we start the supervisor with the children and a strategy
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
