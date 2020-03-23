defmodule JumpUp.WakeUp do
  require Logger
  alias JumpUp.WakeUp.Megaboom
  alias JumpUp.WakeUp.Player

  def trigger() do
    Logger.info("wake up procedure initiated")
    Task.start_link(__MODULE__, :start, [])
  end

  def start() do
    Megaboom.turn_on()
    Process.sleep(5_000)
    Player.start_playing()
  end
end
