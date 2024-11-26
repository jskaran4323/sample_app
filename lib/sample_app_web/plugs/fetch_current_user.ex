
defmodule SampleAppWeb.Plugs.FetchCurrentUser do
  @moduledoc """
  A plug to fetch the current user from the session and assign it.
  """
  alias SampleApp.Accounts

  import Plug.Conn
  # Initialize options (not used here but required)
  def init(opts), do: opts

  # The main plug logic
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
      IO.inspect(user_id, label: "User ID in session")
    if user_id do
      user = Accounts.get_user!(user_id)
      IO.inspect(user, label: "Fetched User")
      assign(conn, :current_user, user)
    else
       IO.puts("No user ID found in session")
      assign(conn, :current_user, nil)
    end
  end
end
