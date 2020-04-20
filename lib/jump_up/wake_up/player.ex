defmodule JumpUp.WakeUp.Player do
  @music_dir Application.fetch_env!(:jump_up, :player)[:music_dir]

  @player_exe "omxplayer"
  @options ["--vol", "-1500", "-o", "alsa:bluealsa"]

  @volume_up_interval_ms 45_000

  @killcheck_interval_ms 60_000

  @max_playing_time_seconds 1800

  @initial_state %{playing: false, proc: nil, started_at: nil}

  use GenServer
  require Logger

  alias Porcelain.Process, as: Proc

  def start_link do
    Logger.debug("#{__MODULE__} starting")
    GenServer.start_link(__MODULE__, @initial_state, name: __MODULE__)
  end

  def start_playing do
    send(__MODULE__, :start_playing)
  end

  def stop do
    send(__MODULE__, :stop)
  end

  ## Defining GenServer Callbacks

  @impl true
  def init(state), do: {:ok, state}

  @impl true
  def handle_info(:start_playing, state) do
    {:ok, wake_up_file} = random_file()
    options = @options ++ [wake_up_file]
    Logger.info("Starting playing with options: #{options}")

    proc =
      Porcelain.spawn(@player_exe, options,
        in: :receive,
        out: {:path, "log/player.log"}
      )

    Logger.info("Successfully started playing")
    Process.send_after(__MODULE__, :volume_up, @volume_up_interval_ms)
    Process.send_after(__MODULE__, :killcheck, @killcheck_interval_ms)

    {:noreply,
     Map.merge(state, %{playing: true, proc: proc, started_at: DateTime.utc_now(), volume: -15})}
  end

  def handle_info(:volume_up, state = %{proc: proc, volume: volume}) do
    new_volume = volume + 3
    Proc.send_input(proc, "+")
    Logger.info("Volume turned up to #{new_volume}")

    if new_volume < 0 do
      Process.send_after(__MODULE__, :volume_up, @volume_up_interval_ms)
    end

    {:noreply, Map.put(state, :volume, new_volume)}
  end

  def handle_info(:killcheck, state = %{started_at: started_at}) do
    diff = DateTime.diff(DateTime.utc_now(), started_at)
    Logger.info("We are #{diff} seconds in!")

    if diff > @max_playing_time_seconds do
      Logger.info("Shutting things down since 30 minutes passed")
      send(self(), :stop)
      {:noreply, @initial_state}
    else
      Process.send_after(__MODULE__, :killcheck, @killcheck_interval_ms)
      {:noreply, state}
    end
  end

  def handle_info(:stop, state = %{proc: proc}) do
    Proc.send_input(proc, "q")
    Proc.stop(proc)
    {:noreply, state}
  end

  defp random_file() do
    with {:ok, files} <- File.ls(@music_dir),
         mp3s <- Enum.filter(files, &String.match?(&1, ~r/.*\.mp3$/)),
         selected_one <- Enum.random(mp3s) do
      {:ok, "#{@music_dir}/#{selected_one}"}
    else
      _ -> {:error, :random_music_file_failed}
    end
  end
end
