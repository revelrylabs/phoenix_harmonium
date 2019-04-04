defmodule Harmonium.Table do
  @moduledoc false

  import Phoenix.HTML.Tag

  def table(opts \\ [], do: block) do
    table_element(:table, [class: "rev-Table"], opts, do: block)
  end

  def table_head(opts \\ [], do: block) do
    table_element(:thead, [class: "rev-Table-head"], opts, do: block)
  end

  def table_body(opts \\ [], do: block) do
    table_element(:tbody, [class: "rev-Table-body"], opts, do: block)
  end

  def table_row(opts \\ [], do: block) do
    table_element(:tr, [class: "rev-Table-row"], opts, do: block)
  end

  def table_header(opts \\ [], do: block) do
    table_element(:th, [class: "rev-Table-header"], opts, do: block)
  end

  def table_data(opts \\ [], do: block) do
    table_element(:td, [class: "rev-Table-Data"], opts, do: block)
  end

  def table_element(tag, default_opts, opts, do: block) do
    opts = Keyword.merge(default_opts, opts)

    content_tag tag, opts do
      block
    end
  end
end
