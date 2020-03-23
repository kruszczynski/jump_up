defmodule JumpUp.Timer.Schedule do
  @schedule Application.fetch_env!(:jump_up, :timer)[:schedule]
  require Logger

  def print_schedule do
    Logger.info("#{__MODULE__} read schedule #{inspect(@schedule)}")
  end

  def time_has_come?(date, time) do
    with true <- weekday?(date),
         :gt <- Time.compare(time, hd(@schedule)) do
      true
    else
      _ -> false
    end
  end

  defp weekday?(day) do
    Date.day_of_week(day) < 6
  end
end
