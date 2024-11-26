defmodule SampleAppWeb.UserController do
  use SampleAppWeb, :controller
  alias SampleApp.Accounts
  alias SampleApp.Accounts.User


  def index(conn, _params) do
    users=Accounts.list_users()
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id})do
    user= Accounts.get_user!(id)
      render(conn, :show, user: user)
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
   @spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
   def edit(conn, %{"id" => id}) do
    user= Accounts.get_user!(id)
    changeset= Accounts.change_user(user)
    render(conn, :edit, user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user= Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, updated_user} ->
        conn
        |> put_flash(:info, "user updated Succesfully")
        |> redirect(to: ~p"/users/#{updated_user.id}")
      {:error, %Ecto.Changeset{}= changeset}->
        render(conn, :edit , user: user, changeset: changeset)

    end
  end
  def delete(conn, %{"id"=> id}) do
     case Accounts.get_user!(id) do
    nil ->
      conn
      |> put_flash(:error, "User not found.")
      |> redirect(to: ~p"/users")

    user ->
      case Accounts.delete_user(user) do
        {:ok, _} ->
          conn =
            if get_session(conn, :user_id) == user.id do
              conn
              |> configure_session(drop: true)
            else
              conn
            end

    conn
    |>put_flash(:info, "User deleted successfully")
    |> redirect(to: ~p"/users")
          end
        end
  end
end
