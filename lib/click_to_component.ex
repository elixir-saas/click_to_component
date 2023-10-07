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
  defmacro render(assigns) do
    if @enabled? do
      quote do
        unquote(__MODULE__).Components.click_to_component(unquote(assigns))
      end
    else
      quote do
        ~H""
      end
    end
  end

  @doc """
  Installs the global `on_mount/1` LiveView hook for handling events.

  Add to your `lib/my_app_web.ex` file as follows:

  ```elixir
  def live_view(opts \\ []) do
    quote do
      use Phoenix.LiveView,
        layout: {MyAppWeb.Layouts, :app}

      require ClickToComponent
      ClickToComponent.install_hooks()

      # Rest of live_view quoted code...
    end
  end
  ```
  """
  defmacro install_hooks() do
    import Phoenix.LiveView

    if @enabled? do
      quote do
        on_mount(unquote(__MODULE__.Hooks))
      end
    end
  end
end
