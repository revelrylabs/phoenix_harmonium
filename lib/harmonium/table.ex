defmodule Harmonium.Table do
  @moduledoc """
  Adds component to render pagination with correct harmonium classes.
  """

  import Phoenix.HTML.Tag

  @doc """
  Constructs a callout class.

      iex> table_class()
      "rev-Table"

      iex> table_class(color: "blue")
      "rev-Table rev-Table--colorblue"

      iex> table_class(bold: true)
      "rev-Table rev-Table--bold"
  """
  def table_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table", modifiers)

  @doc """
  Renders a table element (<table>).

      iex> safe_to_string(table(do: []))
      ~S(<table class="rev-Table"></table>)
  """
  def table(opts \\ []), do: table_element(:table, :table_class, opts)

  @doc """
  Constructs a table head class.

      iex> table_head_class()
      "rev-Table-head"

      iex> table_head_class(stacked: true)
      "rev-Table-head rev-Table-head--stacked"
  """
  def table_head_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table-head", modifiers)

  @doc """
  Renders a table head element (<thead>).

      iex> safe_to_string(table_head(do: []))
      ~S(<thead class="rev-Table-head"></thead>)
  """
  def table_head(opts \\ []), do: table_element(:thead, :table_head_class, opts)

  @doc """
  Constructs a table body class.

      iex> table_body_class()
      "rev-Table-body"

      iex> table_body_class(stacked: true)
      "rev-Table-body rev-Table-body--stacked"
  """
  def table_body_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table-body", modifiers)

  @doc """
  Renders a table body element (<tbody>).

      iex> safe_to_string(table_body(do: []))
      ~S(<tbody class="rev-Table-body"></tbody>)
  """
  def table_body(opts \\ []), do: table_element(:tbody, :table_body_class, opts)

  @doc """
  Constructs a table row class.

      iex> table_row_class()
      "rev-Table-row"

      iex> table_row_class(stacked: true)
      "rev-Table-row rev-Table-row--stacked"
  """
  def table_row_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table-row", modifiers)

  @doc """
  Renders a table row element (<tr>).

      iex> safe_to_string(table_row(do: []))
      ~S(<tr class="rev-Table-row"></tr>)
  """
  def table_row(opts \\ []), do: table_element(:tr, :table_row_class, opts)

  @doc """
  Constructs a table header class.

      iex> table_header_class()
      "rev-Table-header"

      iex> table_header_class(stacked: true)
      "rev-Table-header rev-Table-header--stacked"
  """
  def table_header_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table-header", modifiers)

  @doc """
  Renders a table header element (<th>).

      iex> safe_to_string(table_header(do: []))
      ~S(<th class="rev-Table-header"></th>)
  """
  def table_header(opts \\ []), do: table_element(:th, :table_header_class, opts)

  @doc """
  Constructs a table data class.

      iex> table_data_class()
      "rev-Table-data"

      iex> table_data_class(stacked: true)
      "rev-Table-data rev-Table-data--stacked"
  """
  def table_data_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table-data", modifiers)

  @doc """
  Renders a table data element (<td>).

      iex> safe_to_string(table_data)
      ~S(<td class="rev-Table-data"></td>)

      iex> safe_to_string(table_data(attrs: [colspan: 2]))
      ~S(<td class="rev-Table-data" colspan="2"></td>)

      iex> safe_to_string(table_data(do: []))
      ~S(<td class="rev-Table-data"></td>)

      iex> safe_to_string(table_data(bold: true, attrs: [colspan: 2], do: []))
      ~S(<td class="rev-Table-data rev-Table-data--bold" colspan="2"></td>)

      iex> safe_to_string(table_data(bold: true, italic: true, attrs: [colspan: 2], do: []))
      ~S(<td class="rev-Table-data rev-Table-data--bold rev-Table-data--italic" colspan="2"></td>)
  """
  def table_data(opts \\ []), do: table_element(:td, :table_data_class, opts)

  defp table_element(tag, class_function, opts) do
    {block, opts} = Keyword.pop(opts, :do, [])
    {attrs, modifiers} = Keyword.pop(opts, :attrs, [])
    modifier_classes = apply(__MODULE__, class_function, [modifiers])
    opts = Keyword.merge(attrs, [class: modifier_classes])

    content_tag tag, opts do
      block
    end
  end
end
