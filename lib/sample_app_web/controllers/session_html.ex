defmodule SampleAppWeb.SessionHTML do
    @moduledoc """
  This module contains pages rendered by SessionController.

  See the `Sessions` directory for all templates available.
  """
  use SampleAppWeb, :html
  embed_templates "session_html/*"

  

end
