defmodule JumpUp.Factory do
  alias JumpUp.Repo
  alias JumpUp.Schema.Alarm

  @seed_alarms [
    %{
      day: "Monday",
      time: ~T[06:45:00],
      enabled: true
    },
    %{
      day: "Tuesday",
      time: ~T[06:45:00],
      enabled: true
    },
    %{
      day: "Wednesday",
      time: ~T[06:45:00],
      enabled: true
    },
    %{
      day: "Thursday",
      time: ~T[06:45:00],
      enabled: true
    },
    %{
      day: "Friday",
      time: ~T[06:45:00],
      enabled: true
    },
    %{
      day: "Saturday",
      time: ~T[08:45:00]
    },
    %{
      day: "Sunday",
      time: ~T[08:45:00]
    }
  ]

  def insert_all(:alarms) do
    Repo.insert_all(Alarm, @seed_alarms)
  end
end
