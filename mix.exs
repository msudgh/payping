defmodule Payping.MixProject do
  use Mix.Project

  @github_url "https://github.com/msudgh/payping"

  defp description() do
    """
    PayPing API client for the Elixir language
    """
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Masoud Ghorbani"],
      licenses: ["MIT", "LICENSE.md"],
      links: %{"GitHub" => @github_url}
    ]
  end

  def project do
    [
      app: :payping,
      version: "0.1.2",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "PayPing",
      docs: [source_ref: "v#\{@version\}", main: "readme", extras: ["README.md"]]
    ]
  end

  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger, :jason]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.6.2"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]
end
