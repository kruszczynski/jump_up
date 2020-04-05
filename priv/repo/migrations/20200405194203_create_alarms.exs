defmodule JumpUp.Repo.Migrations.CreateAlarms do
  use Ecto.Migration
  alias JumpUp.Schema.Alarm

  def change do
    create table(:alarms) do
      add(:day, :string, null: false)
      add(:time, :time, null: false)
      add(:enabled, :boolean, default: false, null: false)
    end

    create(index(:alarms, [:day], unique: true))
    flush()

    seed_days()
  end

  defp seed_days do
    initial_alarms = [
      %{
        day: "Monday",
        time: ~T[06:45:00]
      },
      %{
        day: "Tuesday",
        time: ~T[06:45:00]
      },
      %{
        day: "Wednesday",
        time: ~T[06:45:00]
      },
      %{
        day: "Thursday",
        time: ~T[06:45:00]
      },
      %{
        day: "Friday",
        time: ~T[06:45:00]
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

    JumpUp.Repo.insert_all(Alarm, initial_alarms, on_conflict: :raise)
  end
end
