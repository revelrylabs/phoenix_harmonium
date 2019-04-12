defmodule Harmonium.Table do
  @moduledoc false

  import Phoenix.HTML.Tag

  @doc """
  Constructs a callout class.
  """
  def table_class(modifiers \\ []), do: Harmonium.rev_class("rev-Table", modifiers)

  @doc """
  Renders a table element (<table>).
  """
  def table(modifiers \\ [], do: block), do: table(:table, modifiers, do: block)

  def table(tag, modifiers, do: block) do
    content_tag tag, class: table_class(modifiers) do
      block
    end
  end

  @doc """
  Renders a table head element (<thead>).
  """
  def table_head(opts \\ [], do: block) do
    table_element(:thead, [class: "rev-Table-head"], opts, do: block)
  end

  @doc """
  Renders a table body element (<tbody>).
  """
  def table_body(opts \\ [], do: block) do
    table_element(:tbody, [class: "rev-Table-body"], opts, do: block)
  end

  @doc """
  Renders a table row element (<tr>).
  """
  def table_row(opts \\ [], do: block) do
    table_element(:tr, [class: "rev-Table-row"], opts, do: block)
  end

  @doc """
  Renders a table header element (<th>).
  """
  def table_header(opts \\ [], do: block) do
    table_element(:th, [class: "rev-Table-header"], opts, do: block)
  end

  @doc """
  Renders a table data element (<td>).
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
