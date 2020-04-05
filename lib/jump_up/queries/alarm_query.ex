defmodule JumpUp.Queries.AlarmQuery do
  alias JumpUp.Schema.Alarm
  alias JumpUp.Repo
  import Ecto.Query, only: [from: 2]

  def all do
    Repo.all(Alarm)
  end

  def for_day(day) do
    string_day = number_to_day(day)
    query = from(a in Alarm, where: a.day == ^string_day)
    Repo.one!(query)
  end

  defp number_to_day(1), do: "Monday"
  defp number_to_day(2), do: "Tuesday"
  defp number_to_day(3), do: "Wednesday"
  defp number_to_day(4), do: "Thursday"
  defp number_to_day(5), do: "Friday"
  defp number_to_day(6), do: "Saturday"
  defp number_to_day(7), do: "Sunday"
end
