defmodule JumpUp do
  @moduledoc """
  Documentation for JumpUp.
  """
  use Application
  require Logger
  alias JumpUp.Timer

  def start(_type, _args) do
    children = [
      %{
        id: Timer,
        start: {Timer, :start_link, []}
      }
    ]

    Logger.info("Starting core supervisor")
    # Now we start the supervisor with the children and a strategy
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
