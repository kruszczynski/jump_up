defmodule JumpUp.Timer.Schedule do
  @schedule Application.fetch_env!(:jump_up, :timer)[:schedule]

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
