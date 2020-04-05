defmodule JumpUp.Timer.ScheduleTest do
  use JumpUp.RepoCase, async: true

  alias JumpUp.Timer.Schedule

  setup do
    JumpUp.Factory.insert_all(:alarms)
    :ok
  end

  describe ".time_has_come?" do
    test "is false on weekend" do
      saturday = ~D[2020-03-21]
      sunday = ~D[2020-03-15]
      refute Schedule.time_has_come?(saturday, ~T[11:00:00])
      refute Schedule.time_has_come?(sunday, ~T[11:00:00])
    end

    test "is false before the time has come" do
      date = ~D[2019-12-31]
      time = ~T[06:00:00]
      refute Schedule.time_has_come?(date, time)
    end

    test "is false after 30 minutes" do
      date = ~D[2019-12-31]
      time = ~T[07:16:00]
      refute Schedule.time_has_come?(date, time)
    end

    test "is true within the week" do
      date = ~D[2019-12-31]
      time = ~T[06:46:00]
      assert Schedule.time_has_come?(date, time)
    end
  end
end
