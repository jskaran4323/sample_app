defmodule SampleAppWeb.UserController do
  use SampleAppWeb, :controller
  alias SampleApp.Accounts
  alias SampleApp.Accounts.User

  def show(conn, %{"id" => id})do
    user= Accounts.get_user!(id)
    render(conn,"show.html", user: user, title: user.name)
  end

  def create(conn,%{"user"=> user_params}) do
    case Accounts.create_user(user_params) do
      {:ok,user}->
        conn
      |> put_flash(:success, "Welcome to Sample App")
      |> redirect(to: ~p"/users/#{user.id}")

        # handle a successful signup
        {:error, %Ecto.Changeset{}=changeset}->
          render(conn,"new.html", changeset: changeset)
    end
  end
  def new(conn, _params) do
    changeset=Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

end
