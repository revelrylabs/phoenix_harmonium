defmodule Harmonium.MixProject do
  use Mix.Project

  @github "https://github.com/revelrylabs/phoenix_harmonium"

  def project do
    [
      app: :harmonium,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],

      # Docs
      name: "Harmonium",
      source_url: @github,
      homepage_url: @github,
      # The main page in the docs
      docs: [main: "Harmonium", extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_html, "~> 2.11.0"},
      {:excoveralls, "~> 0.8.0", only: :test},
      {:phoenix_ecto, "~> 3.0", only: :test}
    ]
  end

  defp package do
    [
      description: "Styled UI component helpers for Phoenix",
      files: ["lib", "mix.exs", "README.md", "LICENSE", "CHANGELOG.md"],
      maintainers: ["Joel Wietelmann"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @github
      },
      build_tools: ["mix"]
    ]
  end
end
