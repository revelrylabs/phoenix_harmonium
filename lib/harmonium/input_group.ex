defmodule Harmonium.InputGroup do
  @moduledoc """
  The InputGroup is a grouping on several related labels, inputs, and buttons
  together in a compact format. For example, you can group an input, along
  with a relevant caption or unit of measure, along with several buttons
  to take action on that input.
  """
  # import Phoenix.HTML
  # import Phoenix.HTML.Form
  import Phoenix.HTML.Tag

  @input_group_class "rev-InputGroup"
  @input_group_stack_class "rev-InputGroupStack"

  def input_group_class(modifiers \\ []) do
    Harmonium.rev_class(@input_group_class, modifiers)
  end

  def element_class(element, modifiers \\ []) do
    Harmonium.rev_class("#{@input_group_class}-#{element}", modifiers)
  end

  def input_group(do: block), do: input_group([], do: block)

  def input_group(modifiers, do: block) do
    content_tag :div, class: input_group_class(modifiers) do
      block
    end
  end

  def input_group_label(do: block), do: input_group_label([], do: block)

  def input_group_label(modifiers, do: block) do
    content_tag :span, class: element_class("label", modifiers) do
      block
    end
  end

  def input_group_field(do: block), do: input_group_field([], do: block)

  @doc """
  NOTE: in Harmonium, the InputGroup.Field doesn't have any markup of its own.
  Instead it decorates its children with the `rev-InputGroup-field` class
  This is not a thing we can do in Phoenix, but we _can_ create some new CSS that
  applies those styles by targeting the `fieldWrapper` class and child elements
  See app.scss
  """
  def input_group_field(modifiers, do: block) do
    content_tag :div, class: element_class("fieldWrapper", modifiers) do
      block
    end
  end

  def input_group_button(do: block), do: input_group_button([], do: block)

  def input_group_button(modifiers, do: block) do
    content_tag :div, class: element_class("button", modifiers) do
      block
    end
  end

  def input_group_stack(f, key, do: block), do: input_group_stack(f, key, [], do: block)

  @doc """
    NOTE: The stack will only display errors attached to the key provided here,
    regardless of how many different inputs are in the group.
  """
  def input_group_stack(f, key, options, do: block) do
    render = fn _, _, options ->
      input_group(options, [do: block])
    end
    Harmonium.input_stack(render, "", @input_group_stack_class, f, key, options)
  end
end
