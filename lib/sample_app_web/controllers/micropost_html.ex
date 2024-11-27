defmodule SampleAppWeb.MicropostHTML do
  @moduledoc """
  This module contains pages rendered by UserController.

  See the `user_page_html` directory for all templates available.
  """
  use SampleAppWeb, :html
  # import SampleAppWeb.ErrorHelpers
  embed_templates "micropost_html/*"
end