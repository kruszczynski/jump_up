defmodule JumpUp do
  @moduledoc """
  Documentation for JumpUp.
  """
  use Application

  def start(_type, _args) do
    {:ok, self()}
  end
end
