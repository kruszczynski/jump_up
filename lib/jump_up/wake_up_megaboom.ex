defmodule JumpUp.WakeUpMegaboom do
  @handle "0x0003"
  @value Application.fetch_env!(:jump_up, :megaboom)[:source_value]
  @mac Application.fetch_env!(:jump_up, :megaboom)[:target_mac]

  def run do
    options = [
      "-b",
      @mac,
      "--char-write-req",
      "--handle=#{@handle}",
      "--value=#{@value}"
    ]

    System.cmd("gatttool", options)
  end
end
