defmodule JumpUp.Schema.Alarm do
  use Ecto.Schema

  schema "alarms" do
    field(:day, :string)
    field(:time, :time)
    field(:enabled, :boolean)
  end

  def day_to_number(%__MODULE__{day: "Monday"}), do: 1
  def day_to_number(%__MODULE__{day: "Tuesday"}), do: 2
  def day_to_number(%__MODULE__{day: "Wednesday"}), do: 3
  def day_to_number(%__MODULE__{day: "Thursday"}), do: 4
  def day_to_number(%__MODULE__{day: "Friday"}), do: 5
  def day_to_number(%__MODULE__{day: "Saturday"}), do: 6
  def day_to_number(%__MODULE__{day: "Sunday"}), do: 7
end
