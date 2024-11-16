defmodule SampleAppWeb.UserHTML do
  @moduledoc """
  This module contains pages rendered by staticpageController.

  See the `static_page_html` directory for all templates available.
  """
  use SampleAppWeb, :html

  embed_templates "user_html/*"
end
