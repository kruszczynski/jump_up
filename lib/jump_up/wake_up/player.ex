defmodule JumpUp.WakeUp.Player do
  @music_dir Application.fetch_env!(:jump_up, :player)[:music_dir]

  @player_exe "omxplayer"
  @default_options ["--vol", "-1500", "-o", "alsa:bluealsa"]
  @volume_up_interval 45_000

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

    Process.sleep(@volume_up_interval)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")

    Process.sleep(@volume_up_interval)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")

    Process.sleep(@volume_up_interval)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")

    Process.sleep(@volume_up_interval)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")

    Process.sleep(@volume_up_interval)
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up")
  end
end
