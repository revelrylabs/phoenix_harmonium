# Harmonium

[![Build Status](https://travis-ci.org/revelrylabs/phoenix_harmonium.svg?branch=master)](https://travis-ci.org/revelrylabs/phoenix_harmonium)
[![Hex.pm](https://img.shields.io/hexpm/dt/harmonium.svg)](https://hex.pm/packages/harmonium)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Coverage Status](https://coveralls.io/repos/github/revelrylabs/phoenix_harmonium/badge.svg?branch=master)](https://coveralls.io/github/revelrylabs/phoenix_harmonium?branch=master)

Phoenix Framework view helpers for Harmonium-styled HTML without React.

Harmonium was originally conceived as a set of styled React components ([harmonium.revelry.co](https://harmonium.revelry.co/)). This library brings the style and markup framework of Harmonium into Phoenix, but leaves the JavaScript behind.

Here are a just few of the features:

* Flexible grid layout system
* Enhanced form helpers that decorate your inputs with errors and help text in a uniform way
* Functions for inserting just the right CSS class names, for those moments when you want to go off the pre-built path

## Installation

Add `harmonium` to your list of dependencies in `mix.exs` before running `mix deps.get`:

```elixir
def deps do
  [
    {:harmonium, "~> 1.0.0"}
  ]
end
```

From your app's root directory, run this command to get the `harmonium` package from NPM, which contains the SCSS you'll need:

```bash
$(cd assets && npm install --save harmonium)
```

In `assets/app.scss`, import the SCSS:
```scss
@import '~harmonium/scss/app';
```

For more details, and a set of Starter Settings for configuring Harmonium styles, go to [harmonium.revelry.co](https://harmonium.revelry.co/)

## Example Usage
```elixir
<%= form_for @changeset, @action, fn f -> %>
  <%= row do %>
    <%= col medium: 6, large: 4 do %>
      <%= text_input_stack f, :username, label: "Username", help: "Pick a good one. You can't change it later." %>
    <% end %>
    <%= col medium: 6, large: 4 do %>
      <%= password_input_stack f, :password, label: "Password", help: "Make it strong!" %>
    <% end %>
    <%= col medium: 6, large: 4 do %>
      <%= password_input_stack f, :password, label: "Password (confirm)", help: "Type it again." %>
    <% end %>
  <% end %>
  <%= row do %>
    <%= col do %>
      <%= single_checkbox f, :subscribe_to_newsletter, label: "Please, please, please subscribe to my newsletter." %>
    <% end %>
  <% end %>
  <%= row do %>
    <%= col do %>
      <%= submit "Save", class: button_class(expanded: true) %>
    <% end %>
  <% end %>
<% end %>
```

## Making a new release

To deploy and update to the harmonium hex package, you first need to increment version number in `mix.exs`. Afterwards all that needs to be done is to create a new release tag for the new version number, and Travis should deploy the package automatically.
