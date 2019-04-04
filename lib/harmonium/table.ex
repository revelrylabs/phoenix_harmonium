defmodule Harmonium.Table do
  @moduledoc false

  import Phoenix.HTML.Tag

  def table(opts \\ [], do: block) do
    opts = Keyword.merge([class: "rev-Table"], opts)

    content_tag :table, opts do
      block
    end
  end

  def table_head(opts \\ [], do: block) do
    opts = Keyword.merge([class: "rev-Table-head"], opts)

    content_tag :thead, opts do
      block
    end
  end

  def table_body(opts \\ [], do: block) do
    opts = Keyword.merge([class: "rev-Table-body"], opts)

    content_tag :tbody, opts do
      block
    end
  end

  def table_row(opts \\ [], do: block) do
    opts = Keyword.merge([class: "rev-Table-row"], opts)

    content_tag :tr, opts do
      block
    end
  end

  def table_header(opts \\ [], do: block) do
    opts = Keyword.merge([class: "rev-Table-header"], opts)

    content_tag :th, opts do
      block
    end
  end

  def table_data(opts \\ [], do: block) do
    opts = Keyword.merge([class: "rev-Table-Data"], opts)

    content_tag :td, opts do
      block
    end
  end
end
