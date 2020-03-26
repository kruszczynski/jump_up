defmodule JumpUp.Timer do
  use GenServer
  require Logger
  alias JumpUp.Timer.Schedule
  alias JumpUp.WakeUp

  ## Client API

  def start_link do
    Logger.debug("#{__MODULE__} starting")
    Schedule.print_schedule()
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def tick() do
    send(__MODULE__, :tick)
  end

  ## Defining GenServer Callbacks

  @impl true
  def init(state) do
    schedule_tick()
    {:ok, state}
  end

  @impl true
  def handle_info(:tick, state) do
    Logger.debug("#{__MODULE__} ticking")
    {:ok, new_state} = handle_tick(state)
    schedule_tick()
    {:noreply, new_state}
  end

  defp handle_tick(state) do
    with today <- Date.utc_today(),
         false <- Map.has_key?(state, today),
         true <- Schedule.time_has_come?(today, Time.utc_now()) do
      WakeUp.trigger()
      {:ok, Map.put(state, today, true)}
    else
      _ -> {:ok, state}
    end
  end

  defp schedule_tick() do
    Logger.debug("#{__MODULE__} scheduling tick")
    Process.send_after(__MODULE__, :tick, 10_000)
  end
end
