defmodule SampleAppWeb.Plugs.RequireAuth do
  @router SampleAppWeb.Router  # Explicitly set the router module

  import Plug.Conn
  import Phoenix.Controller
  import Phoenix.VerifiedRoutes, only: [path: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: path(conn, ~p"/login"))  # Use Verified Routes
      |> halt()
    end
  end
end
