defmodule ClickToComponent.Components do
  use Phoenix.Component

  attr(:id, :string, default: "click-to-component")

  def click_to_component(assigns) do
    ~H"""
    <div id={@id} phx-hook="ClickToComponent" />
    """
  end
end
