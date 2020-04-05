defmodule JumpUp.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias JumpUp.Repo

      import Ecto
      import Ecto.Query
      import JumpUp.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(JumpUp.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(JumpUp.Repo, {:shared, self()})
    end

    :ok
  end
end
