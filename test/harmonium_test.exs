defmodule Widget do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:required_string, :string)
    field(:bool, :boolean)
  end

  def changeset(%Widget{} = widget, attrs) do
    widget
    |> cast(attrs, [:required_string, :bool])
    |> validate_required([:required_string])
  end

  def new(attrs), do: changeset(%Widget{}, attrs)

  def validate(%Ecto.Changeset{} = changeset), do: apply_action(changeset, :insert)
end

defmodule HarmoniumTest do
  use ExUnit.Case
  import Harmonium
  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Form, only: [form_for: 3]

  def changeset(attrs \\ %{required_string: "hello"}) do
    Widget.new(attrs)
  end

  def changeset_with_errors() do
    changeset(%{required_string: nil})
    |> Widget.validate()
    |> case do
      {:error, change} -> change
    end
  end

  defp to_form(change), do: Phoenix.HTML.FormData.to_form(change, [])

  def f() do
    changeset() |> to_form()
  end

  def form_with_errors() do
    changeset_with_errors() |> to_form()
  end

  doctest Harmonium
end
