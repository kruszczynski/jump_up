defmodule JumpUp.MixProject do
  use Mix.Project

  def project do
    [
      app: :jump_up,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {JumpUp, []},
      applications: [:porcelain],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:porcelain, "~> 2.0"},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end
end
