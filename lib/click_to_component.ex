defmodule ClickToComponent do
  @moduledoc """
  Documentation for `ClickToComponent`.
  """

  require Logger

  @enabled? Application.compile_env(:click_to_component, :enabled, false)

  if @enabled? and !Application.compile_env(:phoenix_live_view, :debug_heex_annotations) do
    Logger.warning("""
    ClickToComponent requires :debug_heex_annotations to be enabled. Add the following configuration in your `config/dev.exs` file:

        config :phoenix_live_view, debug_heex_annotations: true
    """)
  end

  if !@enabled? and Application.compile_env(:phoenix_live_view, :debug_heex_annotations) do
    Logger.warning("""
    It looks like :debug_heex_annotations is enabled, but ClickToComponent is not. To enable, add the following configuration in your `config/dev.exs` file:

        config :click_to_component, enabled: true
    """)
  end

  @doc """
  Renders the ClickToComponent hook.

  Add to your `lib/my_app_web/layouts/root.html.heex` file as follows:

  ```html
  <body>
    <!-- Rest of layout body markup... -->
    <ClickToComponent.render />
  </body>
  ```
  """
  import Phoenix.Component, only: [sigil_H: 2], warn: false

  if @enabled? do
    def render(assigns), do: __MODULE__.Components.click_to_component(assigns)
  else
    def render(assigns), do: ~H""
  end

  @doc """
  Returns the global `on_mount/1` LiveView hook for handling events as quoted code.

  Add to your `lib/my_app_web.ex` file as follows:

  ```elixir
  def live_view(opts \\ []) do
    quote do
      use Phoenix.LiveView,
        layout: {MyAppWeb.Layouts, :app}

      unquote(ClickToComponent.hooks())

      # Rest of live_view quoted code...
    end
  end
  ```
  """
  if @enabled? do
    def hooks() do
      quote do
        on_mount(unquote(__MODULE__.Hooks))
      end
    end
  else
    def hooks(), do: nil
  end
end
