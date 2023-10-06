defmodule ClickToComponent.Hooks do
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    {:cont, attach_hook(socket, :click_to_component, :handle_event, &handle_event/3)}
  end

  defp handle_event("click_to_component:open", %{"path" => path}, socket) do
    {cmd, args} = command_from_config(path)
    System.cmd(cmd, args, cd: File.cwd!())

    {:halt, socket}
  end

  defp handle_event(_event, _params, socket), do: {:cont, socket}

  @default_command {"code", [".", "--goto", :path]}

  def command_from_config(path) do
    {cmd, args} = Application.get_env(:click_to_component, :command, @default_command)
    {cmd, Enum.map(args, &if(&1 == :path, do: path, else: &1))}
  end
end
