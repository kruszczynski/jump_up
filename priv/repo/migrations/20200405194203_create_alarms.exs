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
  end
end
