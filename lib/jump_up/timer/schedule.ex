defmodule JumpUp.Timer.Schedule do
  @alarm_window_size 1800
  require Logger
  alias JumpUp.Queries.AlarmQuery

  def print_schedule do
    Logger.info("#{__MODULE__} current schedule: #{inspect(schedule())}")
  end

  defp schedule do
    AlarmQuery.all()
  end

  def time_has_come?(day, current_time) do
    with day_num <- Date.day_of_week(day),
         %{enabled: true, time: alarm_time} <- alarm_for(day_num),
         :gt <- Time.compare(current_time, alarm_time),
         upper_bound <- Time.add(alarm_time, @alarm_window_size),
         :lt <- Time.compare(current_time, upper_bound) do
      true
    else
      _ -> false
    end
  end

  defp alarm_for(day), do: AlarmQuery.for_day(day)
end
