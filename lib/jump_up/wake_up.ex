defmodule JumpUp.WakeUp do
  require Logger
  alias JumpUp.WakeUpMegaboom

  def trigger() do
    Logger.info("wake up procedure initiated")
    Task.start_link(__MODULE__, :start, [])
  end

  def start() do
    WakeUpMegaboom.run()
  end
end
