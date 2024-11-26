defmodule SampleAppWeb.SessionController do
  use SampleAppWeb, :controller
  alias SampleApp.Accounts

  def new(conn, _params) do
  changeset = Accounts.change_user_login(%{})
  render(conn, "new.html", changeset: changeset)
end


def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
  case Accounts.get_user_by_email_password(email, password) do
    {:ok, user} ->
      conn


      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back, #{user.name}!")
      |> redirect(to: ~p"/users/#{user.id}")

    {:error, _reason} ->
      changeset = Accounts.change_user_login(%{})
      conn
      |> put_flash(:error, "Invalid email or password.")
      |> render(:new, changeset: changeset)
  end


end
def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: ~p"/login")

  end

end
