defmodule Harmonium.Table do
  @moduledoc """
  Adds component to render pagination with correct harmonium classes.
  """

  import Phoenix.HTML.Tag

  @doc """
  Constructs a callout class.

      iex> table_class() == "rev-Table"
      true

      iex> table_class(color: "blue") == "rev-Table rev-Table--colorblue"
      true

      iex> table_class(bold: true) == "rev-Table rev-Table--bold"
      true
  """
  def table_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table", modifiers)

  @doc """
  Renders a table element (<table>).

      iex> safe_to_string(table(do: []))
      ~S(<table class="rev-Table"></table>)
  """
  def table(modifiers \\ [], do: block), do: table(:table, modifiers, do: block)

  def table(tag, modifiers, do: block) do
    content_tag tag, class: table_class(modifiers) do
      block
    end
  end

  @doc """
  Renders a table head element (<thead>).

      iex> safe_to_string(table_head(do: []))
      ~S(<thead class="rev-Table-head"></thead>)
  """
  def table_head(opts \\ [], do: block) do
    table_element(:thead, [class: "rev-Table-head"], opts, do: block)
  end

  @doc """
  Renders a table body element (<tbody>).

      iex> safe_to_string(table_body(do: []))
      ~S(<tbody class="rev-Table-body"></tbody>)
  """
  def table_body(opts \\ [], do: block) do
    table_element(:tbody, [class: "rev-Table-body"], opts, do: block)
  end

  @doc """
  Renders a table row element (<tr>).

      iex> safe_to_string(table_row(do: []))
      ~S(<tr class="rev-Table-row"></tr>)
  """
  def table_row(opts \\ [], do: block) do
    table_element(:tr, [class: "rev-Table-row"], opts, do: block)
  end

  @doc """
  Renders a table header element (<th>).

      iex> safe_to_string(table_header(do: []))
      ~S(<th class="rev-Table-header"></th>)
  """
  def table_header(opts \\ [], do: block) do
    table_element(:th, [class: "rev-Table-header"], opts, do: block)
  end

  @doc """
  Renders a table data element (<td>).

      iex> safe_to_string(table_data(do: []))
      ~S(<td class="rev-Table-Data"></td>)

      iex> safe_to_string(table_data([colspan: 2], do: 1))
      ~S(<td class="rev-Table-Data" colspan="2">1</td>)
  """
  def table_data(opts \\ [], do: block) do
    table_element(:td, [class: "rev-Table-Data"], opts, do: block)
  end

  defp table_element(tag, default_opts, opts, do: block) do
    opts = Keyword.merge(default_opts, opts)

    content_tag tag, opts do
      block
    end
  end
end
