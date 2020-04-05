defmodule JumpUp.Schema.Alarm do
  use Ecto.Schema

  schema "alarms" do
    field(:day, :string)
    field(:time, :time)
    field(:enabled, :boolean)
  end

  def changeset(alarm, params \\ %{}) do
    alarm
    |> Ecto.Changeset.cast(params, [:enabled, :time])
  end
end

defimpl Inspect, for: JumpUp.Schema.Alarm do
  def inspect(%{day: day, time: time, enabled: true}, _opts) do
    "#{day}: #{inspect(time)}"
  end

  def inspect(%{day: day, enabled: false}, _opts) do
    "#{day}: OFF"
  end
end
