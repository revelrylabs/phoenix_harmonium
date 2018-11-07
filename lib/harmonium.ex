defmodule Harmonium do
  @moduledoc """
  Styled HTML grid helpers, form helpers, and more.
  """

  import Phoenix.HTML
  import Phoenix.HTML.Form
  import Phoenix.HTML.Tag

  @row_class "rev-Row"
  @col_class "rev-Col"
  @callout_class "rev-Callout"
  @menu_class "rev-Menu"
  @menu_item_class "rev-Menu-item"
  @label_class "rev-InputLabel"
  @label_text_class "rev-LabelText"
  @input_class "rev-Input"
  @textarea_class "rev-Textarea"
  @select_class "rev-Select"
  @error_class "rev-InputErrors"
  @invalid_class "is-invalid"
  @help_class "rev-HelpText rev-InputHelpText"
  @input_stack_class "rev-InputStack"
  @textarea_stack_class "rev-TextareaStack"
  @select_stack_class "rev-SelectStack"
  @button_class "rev-Button"
  @button_group_class "rev-ButtonGroup"
  @card_class "rev-Card"
  @card_header_class "#{@card_class}-header"
  @card_body_class "#{@card_class}-body"
  @card_footer_class "#{@card_class}-footer"
  @drawer_class "rev-Drawer"
  @drawer_class_when_open "#{@drawer_class}--open"
  @drawer_closer_class "#{@drawer_class}-closer"
  @drawer_expander_class "#{@drawer_class}-expander"
  @drawer_contents_class "#{@drawer_class}-contents"
  @icon_class "rev-Icon"

  @doc """
  Constructs a CSS class with SUIT modifiers.

  With no `modifiers`, it simply returns the `base_class`.

      iex> rev_class(:Column, [])
      "Column"

  For a boolean modifier `{key, value}`, it modifies the class with `key` only if `value` is true.

      iex> rev_class(:Column, shrink: true)
      "Column Column--shrink"
      iex> rev_class(:Column, shrink: false)
      "Column"

  For a non-boolean modifier `{key, value}`, it concatenates key and value.

      iex> rev_class(:Column, medium: 4, large: 3, justify: :Left)
      "Column Column--medium4 Column--large3 Column--justifyLeft"

  For the special-case `{:class, value}`, it skips SUIT conventions and adds `value` directly

      iex> rev_class(:Column, medium: 4, class: "more css classes")
      "Column Column--medium4 more css classes"
  """

  def rev_class(base_class, nil), do: rev_class(base_class, [])

  def rev_class(base_class, modifiers) when is_atom(base_class),
    do: rev_class("#{base_class}", modifiers)

  def rev_class(base_class, modifiers) when is_bitstring(base_class) do
    modifiers
    |> Enum.reduce(base_class, fn {modifier, value}, class ->
      case modifier do
        :class ->
          "#{class} #{value}"

        _ ->
          case value do
            false -> class
            true -> "#{class} #{base_class}--#{modifier}"
            other -> "#{class} #{base_class}--#{modifier}#{other}"
          end
      end
    end)
  end

  @doc """
  Constructs a grid row class, following the modifier rules of `rev_class/2`.

      iex> row_class()
      "#{@row_class}"
      iex> row_class(flex: true)
      "#{@row_class} #{@row_class}--flex"
  """
  def row_class(modifiers \\ []), do: rev_class(@row_class, modifiers)

  @doc """
  Renders grid row.

      iex> row(do: "hello") |> safe_to_string()
      "<div class=\\\"#{@row_class}\\\">hello</div>"
      iex> row(flex: true) do "hello" end |> safe_to_string()
      "<div class=\\\"#{@row_class} #{@row_class}--flex\\\">hello</div>"
      iex> row(:section, flex: true) do "hello" end |> safe_to_string()
      "<section class=\\\"#{@row_class} #{@row_class}--flex\\\">hello</section>"
  """
  def row(do: block), do: row([], do: block)

  def row(modifiers, do: block), do: row(:div, modifiers, do: block)

  def row(tag, modifiers, do: block) do
    content_tag tag, class: row_class(modifiers) do
      block
    end
  end

  @doc """
  Constructs a grid column class. (Same usage as `row_class/1`.)
  """
  def col_class(modifiers \\ []), do: rev_class(@col_class, modifiers)

  @doc """
  Renders a grid column. (Same usage as `rev_row/1`, `rev_row/2`, `rev_row/3`.)
  """
  def col(do: block), do: col([], do: block)

  def col(modifiers, do: block), do: col(:div, modifiers, do: block)

  def col(tag, modifiers, do: block) do
    content_tag tag, class: col_class(modifiers) do
      block
    end
  end

  @doc """
  Constructs a callout class.
  """
  def callout_class(modifiers \\ []), do: rev_class(@callout_class, modifiers)

  @doc """
  Renders a callout.
  """
  def callout(do: block), do: callout([], do: block)

  def callout(modifiers, do: block), do: callout(:div, modifiers, do: block)

  def callout(tag, modifiers, do: block) do
    content_tag tag, class: callout_class(modifiers) do
      block
    end
  end

  @doc """
  Constructs a menu class.
  """
  def menu_class(modifiers \\ []), do: rev_class(@menu_class, modifiers)

  @doc """
  Renders a menu.
  """
  def menu(do: block), do: menu([], do: block)

  def menu(modifiers, do: block), do: menu(:div, modifiers, do: block)

  def menu(tag, modifiers, do: block) do
    content_tag tag, class: menu_class(modifiers) do
      block
    end
  end

  @doc """
  Constructs a menu item class.
  """

  def menu_item_class(modifiers \\ []), do: rev_class(@menu_item_class, modifiers)

  @doc """
  Renders a rev-Menu-item.
  """
  def menu_item(do: block), do: menu_item([], do: block)

  def menu_item(modifiers, do: block), do: menu_item(:div, modifiers, do: block)

  def menu_item(tag, modifiers, do: block) do
    content_tag tag, class: menu_item_class(modifiers) do
      block
    end
  end

  @doc """
  Constructs an input label class.
  """
  def rev_label_class(modifiers \\ []), do: rev_class(@label_class, modifiers)

  @doc """
  Renders an input label.
  """
  def rev_label(modifiers, do: block) do
    content_tag :label, class: rev_label_class(modifiers) do
      block
    end
  end

  @doc """
  Renders an input label inner `<span>`.
  """
  def rev_label_text(do: block) do
    content_tag :span, class: @label_text_class do
      block
    end
  end

  @doc """
  Renders an input error `<small>`.
  """
  def rev_error_text(do: block) do
    content_tag :small, class: @error_class do
      block
    end
  end

  @doc """
  Renders an input help `<small>`.
  """
  def rev_help_text(do: block) do
    content_tag :small, class: @help_class do
      block
    end
  end

  # Extract an error for a given key from Phoenix form data.
  defp extract_error(f, key) do
    case List.keyfind(f.errors, key, 0) do
      nil -> nil
      {_key, {text, _validation}} -> text
    end
  end

  # For building very typical Harmonium form input stacks.
  # See `text_input_stack/3` and `select_stack/4` for example usage.
  # For other, less uniform input types, you may have to write something more custom.
  # In those cases, this function's code can still be a good reference example.
  defp input_stack(func, input_class, stack_class, f, key, options, value_options \\ nil) do
    error = extract_error(f, key)

    validity_class = if error, do: @invalid_class, else: ""

    label_text =
      case options[:label] do
        nil -> nil
        value -> rev_label_text(do: value)
      end

    input_options =
      options
      |> Keyword.get(:input, [])
      |> Keyword.put(:class, "#{input_class} #{validity_class}")

    input =
      case value_options do
        nil -> func.(f, key, input_options)
        _ -> func.(f, key, value_options, input_options)
      end

    error_text =
      case error do
        nil -> nil
        _ -> rev_error_text(do: error)
      end

    help_text =
      case options[:help] do
        nil -> nil
        value -> rev_help_text(do: value)
      end

    rev_label class: "#{stack_class} #{validity_class}" do
      ~E"""
        <%= label_text %>
        <%= input %>
        <%= error_text %>
        <%= help_text %>
      """
    end
  end

  @doc """
  Harmonium provides a number of shortcuts for building richly-styled form inputs.
  We refer to these as "stacks."
  A stack is a label wrapper around an input with optional label text, help text, and error display.
  Under the covers, these stack helpers uses the input helpers from `Phoenix.HTML.Form`.

  This particular function renders a text input stack.

      iex> text_input_stack(f, :required_string) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack \\\">  \\n  <input class=\\\"rev-Input \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" type=\\\"text\\\" value=\\\"hello\\\">\\n  \\n  \\n</label>"

  You may optionally add a label.

      iex> text_input_stack(f, :required_string, label: "Required String") |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack \\\">  <span class=\\\"rev-LabelText\\\">Required String</span>\\n  <input class=\\\"rev-Input \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" type=\\\"text\\\" value=\\\"hello\\\">\\n  \\n  \\n</label>"

  You may optionally add help.

      iex> text_input_stack(f, :required_string, help: "This field is required.") |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack \\\">  \\n  <input class=\\\"rev-Input \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" type=\\\"text\\\" value=\\\"hello\\\">\\n  \\n  <small class=\\\"rev-HelpText rev-InputHelpText\\\">This field is required.</small>\\n</label>"

  The `:input` option passes another set of options through to the `<input>` field.

      iex> text_input_stack(f, :required_string, input: [placeholder: "Required String"]) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack \\\">  \\n  <input class=\\\"rev-Input \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" placeholder=\\\"Required String\\\" type=\\\"text\\\" value=\\\"hello\\\">\\n  \\n  \\n</label>"

  When the field has an error, error styles are applied, and it is displayed.

      iex> text_input_stack(form_with_errors, :required_string) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack is-invalid\\\">  \\n  <input class=\\\"rev-Input is-invalid\\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" type=\\\"text\\\">\\n  <small class=\\\"rev-InputErrors\\\">can&#39;t be blank</small>\\n  \\n</label>"
  """
  def text_input_stack(f, key, options \\ []) do
    input_stack(&text_input/3, @input_class, @input_stack_class, f, key, options)
  end

  @doc """
  See `text_input_stack/3`.
  """
  def password_input_stack(f, key, options \\ []) do
    input_stack(&password_input/3, @input_class, @input_stack_class, f, key, options)
  end

  @doc """
  Renders a textarea stack.

      iex> textarea_stack(f, :required_string) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-TextareaStack \\\">  \\n  <textarea class=\\\"rev-Textarea \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\">\\nhello</textarea>\\n  \\n  \\n</label>"

  See `text_input_stack/3` for more options.
  """
  def textarea_stack(f, key, options \\ []) do
    input_stack(&textarea/3, @textarea_class, @textarea_stack_class, f, key, options)
  end

  @doc """
  Renders an email input stack.

      iex> text_input_stack(f, :required_string) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack \\\">  \\n  <input class=\\\"rev-Input \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" type=\\\"text\\\" value=\\\"hello\\\">\\n  \\n  \\n</label>"

  See `text_input_stack/3` for more options.
  """
  def email_input_stack(f, key, options \\ []) do
    input_stack(&email_input/3, @input_class, @input_stack_class, f, key, options)
  end

  @doc """
  Renders a number input stack.

      iex> text_input_stack(f, :required_string) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack \\\">  \\n  <input class=\\\"rev-Input \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" type=\\\"text\\\" value=\\\"hello\\\">\\n  \\n  \\n</label>"

  See `text_input_stack/3` for more options.
  """
  def number_input_stack(f, key, options \\ []) do
    input_stack(&number_input/3, @input_class, @input_stack_class, f, key, options)
  end

  @doc """
  Renders a phone input stack.

      iex> phone_input_stack(f, :required_string) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-InputStack \\\">  \\n  <input class=\\\"rev-Input \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\" type=\\\"phone\\\" value=\\\"hello\\\">\\n  \\n  \\n</label>"

  See `text_input_stack/3` for more options.
  """

  def phone_input_stack(f, key, options \\ []) do
    input_stack(&telephone_input/3, @input_class, @input_stack_class, f, key, options)
  end

  @doc """
  Similar usage to `text_input_stack/3`, but it also passes `value_options` through to `Phoenix.HTML.Form.select/4`.

    iex> select_stack(f, :required_string, ["Hi": "hi", "Hello": "hello"]) |> safe_to_string()
    "<label class=\\\"rev-InputLabel rev-SelectStack \\\">  \\n  <select class=\\\"rev-Select \\\" id=\\\"widget_required_string\\\" name=\\\"widget[required_string]\\\"><option value=\\\"hi\\\">Hi</option><option value=\\\"hello\\\" selected>Hello</option></select>\\n  \\n  \\n</label>"

  See `text_input_stack/3` for more options.
  """
  def select_stack(f, key, value_options, options \\ []) do
    input_stack(&select/4, @select_class, @select_stack_class, f, key, options, value_options)
  end

  @doc """
  Same as `select_stack/4`, but renders the input as a `<select multiple>` and submits the list of all selected options.

    iex> multiple_select_stack(f, :required_string, ["Hi": "hi", "Hello": "hello"]) |> safe_to_string()
    "<label class=\\\"rev-InputLabel rev-SelectStack \\\">  \\n  <select class=\\\"rev-Select \\\" id=\\\"widget_required_string\\\" multiple=\\\"\\\" name=\\\"widget[required_string][]\\\"><option value=\\\"hi\\\">Hi</option><option value=\\\"hello\\\" selected>Hello</option></select>\\n  \\n  \\n</label>"

  See `text_input_stack/3` for more options.
  """
  def multiple_select_stack(f, key, value_options, options \\ []) do
    input_stack(
      &multiple_select/4,
      @select_class,
      @select_stack_class,
      f,
      key,
      options,
      value_options
    )
  end

  @doc """
  Render a single checkbox.

      iex> single_checkbox(f, :bool) |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-Checkbox\\\"><input name=\\\"widget[bool]\\\" type=\\\"hidden\\\" value=\\\"false\\\"><input class=\\\"rev-Checkbox-input\\\" id=\\\"widget_bool\\\" name=\\\"widget[bool]\\\" type=\\\"checkbox\\\" value=\\\"true\\\"></label>"

  You may optionally add a label:

      iex> single_checkbox(f, :bool, label: "Publish?") |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-Checkbox\\\"><input name=\\\"widget[bool]\\\" type=\\\"hidden\\\" value=\\\"false\\\"><input class=\\\"rev-Checkbox-input\\\" id=\\\"widget_bool\\\" name=\\\"widget[bool]\\\" type=\\\"checkbox\\\" value=\\\"true\\\"><span class=\\\"rev-Checkbox-label\\\">Publish?</span></label>"
  """
  def single_checkbox(f, key, options \\ []) do
    input_options =
      options
      |> Keyword.get(:input, [])
      |> Keyword.put(:class, "rev-Checkbox-input")

    box = checkbox(f, key, input_options)

    label =
      case options[:label] do
        nil ->
          nil

        text ->
          content_tag :span, class: "rev-Checkbox-label" do
            text
          end
      end

    rev_label class: "rev-Checkbox" do
      ~E"<%= box %><%= label %>"
    end
  end

  @doc """
  Render a single radio button.

      iex> single_radio_button(f, :required_string, "one") |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-Radio\\\"><input class=\\\"rev-Radio-input\\\" id=\\\"widget_required_string_one\\\" name=\\\"widget[required_string]\\\" type=\\\"radio\\\" value=\\\"one\\\"></label>"

  You may optionally add a label:

      iex> single_radio_button(f, :required_string, "one", label: "Option One") |> safe_to_string()
      "<label class=\\\"rev-InputLabel rev-Radio\\\"><input class=\\\"rev-Radio-input\\\" id=\\\"widget_required_string_one\\\" name=\\\"widget[required_string]\\\" type=\\\"radio\\\" value=\\\"one\\\"><span class=\\\"rev-Radio-label\\\">Option One</span></label>"
  """
  def single_radio_button(f, key, value, options \\ []) do
    input_options =
      options
      |> Keyword.get(:input, [])
      |> Keyword.put(:class, "rev-Radio-input")

    box = radio_button(f, key, value, input_options)

    label =
      case options[:label] do
        nil ->
          nil

        text ->
          content_tag :span, class: "rev-Radio-label" do
            text
          end
      end

    rev_label class: "rev-Radio" do
      ~E"<%= box %><%= label %>"
    end
  end

  def button_class(modifiers \\ []), do: rev_class(@button_class, modifiers)

  def button_group_class(modifiers \\ []), do: rev_class(@button_group_class, modifiers)

  def button_group(do: block), do: button_group([], do: block)

  def button_group(modifiers, do: block) do
    content_tag :div, class: button_group_class(modifiers) do
      block
    end
  end

  def card_class(modifiers \\ []), do: rev_class(@card_class, modifiers)
  def card_header_class(modifiers \\ []), do: rev_class(@card_header_class, modifiers)
  def card_body_class(modifiers \\ []), do: rev_class(@card_body_class, modifiers)
  def card_footer_class(modifiers \\ []), do: rev_class(@card_footer_class, modifiers)

  def card(do: block), do: card([], do: block)

  def card(modifiers, do: block), do: card(:div, modifiers, do: block)

  def card(tag, modifiers, do: block) do
    content_tag tag, class: card_class(modifiers) do
      block
    end
  end

  def card_header(do: block), do: card_header([], do: block)

  def card_header(modifiers, do: block), do: card_header(:div, modifiers, do: block)

  def card_header(tag, modifiers, do: block) do
    content_tag tag, class: card_header_class(modifiers) do
      block
    end
  end

  def card_body(do: block), do: card_body([], do: block)

  def card_body(modifiers, do: block), do: card_body(:div, modifiers, do: block)

  def card_body(tag, modifiers, do: block) do
    content_tag tag, class: card_body_class(modifiers) do
      block
    end
  end

  def card_footer(do: block), do: card_footer([], do: block)

  def card_footer(modifiers, do: block), do: card_footer(:div, modifiers, do: block)

  def card_footer(tag, modifiers, do: block) do
    content_tag tag, class: card_footer_class(modifiers) do
      block
    end
  end

  def icon_class(icon_name), do: "#{@icon_class}--#{icon_name}"

  def icon(icon_name), do: icon(:span, icon_name)

  def icon(tag, icon_name) do
    content_tag tag, class: icon_class(icon_name) do
      nil
    end
  end

  def rev_data(attrs) do
    [{"init", true} | attrs]
    |> Enum.map(fn
      {key, value} -> {"rev-#{key}", value}
      key -> "rev-#{key}"
    end)
  end

  def drawer_class(modifiers \\ []), do: rev_class(@drawer_class, modifiers)
  def drawer_closer_class(modifiers \\ []), do: rev_class(@drawer_closer_class, modifiers)
  def drawer_expander_class(modifiers \\ []), do: rev_class(@drawer_expander_class, modifiers)
  def drawer_contents_class(modifiers \\ []), do: rev_class(@drawer_contents_class, modifiers)

  def drawer(do: block), do: drawer([], do: block)
  def drawer(modifiers, do: block), do: drawer(:div, modifiers, do: block)

  def drawer(tag, modifiers, do: block) do
    {expander_content, modifiers} = Keyword.pop(modifiers, :expander, icon("open"))
    {closer_content, modifiers} = Keyword.pop(modifiers, :closer, icon("close"))

    expander =
      content_tag :a,
        class: drawer_expander_class(),
        data: rev_data(parent: @drawer_class, add_class: @drawer_class_when_open) do
        expander_content
      end

    closer =
      content_tag :a,
        class: drawer_closer_class(),
        data: rev_data(parent: @drawer_class, remove_class: @drawer_class_when_open) do
        closer_content
      end

    contents =
      content_tag :div, class: drawer_contents_class() do
        ~E"""
        <%= closer %>
        <%= block %>
        """
      end

    content_tag tag, class: drawer_class(modifiers) do
      ~E"""
      <%= expander %>
      <%= contents %>
      """
    end
  end
end
