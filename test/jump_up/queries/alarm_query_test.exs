defmodule JumpUp.Queries.AlarmQueryTest do
  use JumpUp.RepoCase, async: true
  alias JumpUp.Queries.AlarmQuery
  alias JumpUp.Factory

  setup do
    Factory.insert_all(:alarms)

    :ok
  end

  describe "#all" do
    test "gets them all" do
      assert Enum.count(AlarmQuery.all()) == 7
    end
  end

  describe "#for_day" do
    test "fetches one alarm" do
      assert %{day: "Tuesday", time: ~T[06:45:00], enabled: true} = AlarmQuery.for_day(2)
      assert %{day: "Sunday", time: ~T[08:45:00], enabled: false} = AlarmQuery.for_day(7)
    end
  end
end
