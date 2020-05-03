defmodule JumpUp.WakeUp do
  require Logger
  alias JumpUp.WakeUp.Megaboom
  alias JumpUp.WakeUp.Player

  @megaboom_turn_on_timeout_ms 7_500

  def trigger() do
    Logger.info("Wake up procedure initiated")
    Task.start_link(__MODULE__, :start, [])
  end

  def start() do
    Megaboom.turn_on()
    Process.sleep(@megaboom_turn_on_timeout_ms)
    Player.start_playing()
  end
end
