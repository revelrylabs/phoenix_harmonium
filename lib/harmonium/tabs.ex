defmodule Harmonium.Tabs do
  @moduledoc """
  Adds component to render tabs with correct harmonium classes. The options
  get passed to the content_tag so it can be used to trigger liveview events.

  Example

  ```
  <%= tabs_wrapper do %>
    <%= tab_item "First", selected: true, to: page_path(@conn, :styleguide, tab: "first") %>
    <%= tab_item "Second", to: page_path(@conn, :styleguide, tab: "second") %>
  <% end %>
  ```
  """
  import Harmonium, only: [rev_class: 2]
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import Phoenix.HTML.Link, only: [link: 2]

  @doc """
  Renders a wrapper for a list of tabs

      iex> safe_to_string(tabs_wrapper(do: [])) =~ "rev-Tabs"
      true

      iex> safe_to_string(tabs_wrapper([class: "test"], do: [])) =~ "test"
      true
  """
  def tabs_wrapper(do: block), do: tabs_wrapper([], do: block)

  def tabs_wrapper(opts \\ [], do: block) do
    content_tag(:div, class: rev_class("rev-Tabs", opts)) do
      content_tag(:ul, class: "rev-Tabs-titles") do
        block
      end
    end
  end

  @doc """
  Renders a tab item

      iex> safe_to_string(tab_item("First")) =~ "First"
      true

      iex> safe_to_string(tab_item("Second", selected: true)) =~ "rev-TabsTitle--selected"
      true

      iex> safe_to_string(tab_item("Second", phx_click: "handle_it")) =~ "phx-click"
      true
  """
  def tab_item(name, opts \\ []) do
    {selected, opts} = Keyword.pop(opts, :selected, false)
    {to, opts} = Keyword.pop(opts, :to, "#")
    opts = Keyword.merge(opts, class: rev_class("rev-TabsTitle", selected: selected))

    content_tag(:li, opts) do
      link(name, to: to, class: "rev-TabsTitle-link")
    end
  end
end
