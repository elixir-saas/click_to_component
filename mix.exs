defmodule ClickToComponent.MixProject do
  use Mix.Project

  def project do
    [
      app: :click_to_component,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix_live_view, "~> 0.20"}
    ]
  end
end
