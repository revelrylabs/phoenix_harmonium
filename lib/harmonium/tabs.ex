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

  @tabs_wrapper_class "rev-Tabs"
  @tabs_titles_class "rev-Tabs-titles"
  @tabs_title_class "rev-Tabs-title"
  @tabs_title_link_class "rev-TabsTitle-link"

  def tabs_wrapper_class(modifiers \\ []), do: rev_class(@tabs_wrapper_class, modifiers)
  def tabs_titles_class(modifiers \\ []), do: rev_class(@tabs_titles_class, modifiers)
  def tabs_title_class(modifiers \\ []), do: rev_class(@tabs_title_class, modifiers)
  def tabs_title_link_class(modifiers \\ []), do: rev_class(@tabs_title_link_class, modifiers)

  @doc """
  Renders a wrapper for a list of tabs

      iex> safe_to_string(tabs_wrapper(do: "test"))
      ~S(<div class="rev-Tabs">test</div>)

      iex> safe_to_string(tabs_wrapper(bold: true, do: "test"))
      ~S(<div class="rev-Tabs rev-Tabs--bold">test</div>)

      iex> safe_to_string(tabs_wrapper(color: "black", do: "test"))
      ~S(<div class="rev-Tabs rev-Tabs--colorblack">test</div>)

      iex> safe_to_string(tabs_wrapper(:section, color: "black", do: "test"))
      ~S(<section class="rev-Tabs rev-Tabs--colorblack">test</section>)
  """
  def tabs_wrapper(opts), do: tabs_wrapper(:div, opts)

  def tabs_wrapper(tag, opts) do
    {block, modifiers} = Keyword.pop(opts, :do, [])
    content_tag(tag, class: tabs_wrapper_class(modifiers)) do
      block
    end
  end


  @doc """
  Renders a tabs titles wrapper

      iex> safe_to_string(tabs_titles(do: "test"))
      ~S(<ul class="rev-Tabs-titles">test</ul>)

      iex> safe_to_string(tabs_titles(bold: true, do: "test"))
      ~S(<ul class="rev-Tabs-titles rev-Tabs-titles--bold">test</ul>)

      iex> safe_to_string(tabs_titles(color: "black", do: "test"))
      ~S(<ul class="rev-Tabs-titles rev-Tabs-titles--colorblack">test</ul>)
  """
  def tabs_titles(opts), do:  tabs_titles(:ul, opts)

  def tabs_titles(tag, opts) do
    {block, modifiers} = Keyword.pop(opts, :do, [])
    content_tag(tag, class: tabs_titles_class(modifiers)) do
      block
    end
  end

  @doc """
  Renders a tab title

      iex> safe_to_string(tabs_title(do: "test"))
      ~S(<li class="rev-Tabs-title">test</li>)

      iex> safe_to_string(tabs_title(selected: true, do: "test"))
      ~S(<li class="rev-Tabs-title rev-Tabs-title--selected">test</li>)
  """
  def tabs_title(opts), do: tabs_title(:li, opts)

  def tabs_title(tag, opts) do
    {block, modifiers} = Keyword.pop(opts, :do, [])
    content_tag(tag, class: tabs_title_class(modifiers)) do
      block
    end
  end

  @doc """
  Renders a tab title

      iex> safe_to_string(tabs_title_link("Name", to: "#"))
      ~S(<a class="rev-TabsTitle-link" href="#">Name</a>)

      iex> safe_to_string(tabs_title_link("Name", to: "#"))
      ~S(<a class="rev-TabsTitle-link" href="#">Name</a>)

      iex> safe_to_string(tabs_title_link("Name", to: "#", phx_click: "handle_it"))
      ~S(<a class="rev-TabsTitle-link" href="#" phx-click="handle_it">Name</a>)
  """
  def tabs_title_link(name, opts \\ []) do
    opts = Keyword.put(opts, :class, @tabs_title_link_class)
    link(name, opts)
  end
end
