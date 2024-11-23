defmodule SampleAppWeb.GravatarHelper do
  defp md5_hexdigest(str) do
    :crypto.hash(:md5, str)
    |> Base.encode16(case: :lower)
  end

  @doc """
  Renders a Gravatar image for the given user.
  """
  def gravatar_for(%{email: email, name: name}) do
    gravatar_id = String.downcase(email) |> md5_hexdigest()
    IO.puts("ID:  "<> gravatar_id)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    """
    <img src="#{gravatar_url}" alt="#{name}" class="gravatar" />
    """
    |> Phoenix.HTML.raw()
  end
end
