defmodule JumpUp.WakeUp.Megaboom do
  @handle "0x0003"
  @value Application.fetch_env!(:jump_up, :megaboom)[:source_value]
  @mac Application.fetch_env!(:jump_up, :megaboom)[:target_mac]

  require Logger

  def turn_on do
    options = [
      "-b",
      @mac,
      "--char-write-req",
      "--handle=#{@handle}",
      "--value=#{@value}"
    ]

    {response, exit_code} = System.cmd("gatttool", options)

    case exit_code do
      0 -> Logger.info("Successfully turned on megaboom")
      1 -> Logger.error("Megaboom turn on failed")
    end

    {response, exit_code}
  end
end
