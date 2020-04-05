defmodule JumpUp.Schema.AlarmTest do
  use JumpUp.RepoCase, async: true

  alias JumpUp.Schema.Alarm
  alias JumpUp.Repo

  describe ".day_to_number" do
    @days_map %{
      "Monday" => 1,
      "Tuesday" => 2,
      "Wednesday" => 3,
      "Thursday" => 4,
      "Friday" => 5,
      "Saturday" => 6,
      "Sunday" => 7
    }

    test "calculates correctly" do
      Alarm
      |> Repo.all()
      |> Enum.each(fn alarm ->
        assert(Alarm.day_to_number(alarm) == @days_map[alarm.day])
      end)
    end
  end
end
