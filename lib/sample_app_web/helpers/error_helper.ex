defmodule SampleAppWeb.ErrorHelpers do
  @moduledoc """
  Provides helper functions for rendering error messages in forms.
  """



  @doc """
  Generates a tag displaying the number of errors in the form.
  """
  def error_count_tag(form) do
  error_count = Enum.count(form.errors)

  message =
    Gettext.ngettext(
      SampleAppWeb.Gettext,
      "1 error",
      "%{count} errors",
      error_count,
      count: error_count
    )

  """
  <div class="alert alert-danger">
    The form contains #{message}.
  </div>
  """
end

  @doc """
  Generates tags for inlined form input errors.
  """
def error_tag(form, field) do
  Enum.map(Keyword.get_values(form.errors, field), fn error ->
    translated_error = translate_error(error)

    """
    <span class="text-red-500 text-sm" phx-feedback-for="#{field}">
      #{translated_error}
    </span>
    """
  end)
  |> Enum.join("\n") # Join multiple error tags into one string
end

  @doc """
  Translates an error message using Gettext.
  """
 def translate_error({msg, opts}) do
  if count = opts[:count] do
    Gettext.dngettext(SampleAppWeb.Gettext, "errors", msg, msg, count, opts)
  else
    Gettext.dgettext(SampleAppWeb.Gettext, "errors", msg, opts)
  end
end

end
