defmodule JumpUp.WakeUp.Player do
  @music_dir Application.fetch_env!(:jump_up, :player)[:music_dir]

  @player_exe "omxplayer"
  @default_options ["--vol", "-1200", "-o", "alsa:bluealsa"]

  require Logger

  alias Porcelain.Process, as: Proc

  def start_playing do
    options = @default_options ++ [@music_dir]
    Logger.info("Playing with options: #{options}")

    proc =
      Porcelain.spawn(@player_exe, options,
        in: :receive,
        out: {:path, "log/player.log"}
      )

    Logger.info("Successfully started Playing")

    Process.sleep(20_000)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")
    Process.sleep(20_000)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")
    Process.sleep(20_000)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")
  end
end
