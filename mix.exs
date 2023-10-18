defmodule ClickToComponent.MixProject do
  use Mix.Project

  def project do
    [
      app: :click_to_component,
      version: "0.2.2",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      name: "Click To Component",
      description: "Click-to-component functionality for LiveView apps.",
      package: package(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix_live_view, ">= 0.20.0"},
      {:esbuild, "~> 0.2", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Justin Tormey"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/elixir-saas/click_to_component"
      },
      files: ~w(assets/js lib priv mix.exs package.json README.md)
    ]
  end

  defp aliases do
    [
      "assets.build": ["esbuild module", "esbuild cdn", "esbuild cdn_min", "esbuild main"],
      "assets.watch": ["esbuild module --watch"]
    ]
  end
end
