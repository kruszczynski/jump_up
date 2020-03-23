defmodule JumpUp.WakeUp.Player do
  @music_dir Application.fetch_env!(:jump_up, :player)[:music_dir]

  @player_exe "omxplater"
  @default_options ["--vol", "-1200", "-o", "alsa:bluealsa"]

  alias Porcelain.Process, as: Proc

  def start_playing do
    options = @default_options ++ [@music_dir]

    proc =
      Porcelain.spawn(@player_exe, options,
        in: :receive,
        out: {:path, "log/player.log"}
      )

    Process.sleep(20_000)
    Proc.send_input(proc, "+")
    Process.sleep(20_000)
    Proc.send_input(proc, "+")
    Process.sleep(20_000)
    Proc.send_input(proc, "+")
  end
end
