defmodule JumpUp.Timer.Schedule do
  @schedule Application.fetch_env!(:jump_up, :timer)[:schedule]
  @window_size 1800
  require Logger

  def print_schedule do
    Logger.info("#{__MODULE__} loaded following schedule: #{inspect(@schedule)}")
  end

  def time_has_come?(date, time) do
    with true <- weekday?(date),
         lower_bound <- hd(@schedule),
         :gt <- Time.compare(time, lower_bound),
         upper_bound <- Time.add(lower_bound, @window_size),
         :lt <- Time.compare(time, upper_bound) do
      true
    else
      _ -> false
    end
  end

  defp weekday?(day) do
    Date.day_of_week(day) < 6
  end
end
