defmodule Clinic.Mixfile do
  use Mix.Project

  def project do
    [
      app: :clinic,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Clinic.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13.0"},

      {:bypass, "~> 0.8.1", only: :test}
    ]
  end
end
