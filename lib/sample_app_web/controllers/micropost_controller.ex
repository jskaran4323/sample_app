defmodule SampleAppWeb.MicropostController do
  use SampleAppWeb, :controller
  alias SampleApp.Microposts
  alias SampleApp.Microposts.Micropost

  plug SampleAppWeb.Plugs.RequireAuth when action in [:new,:create, :edit, :update, :delete]

  def show(conn, %{"id" => id}) do

  user = SampleApp.Repo.get!(SampleApp.Accounts.User, id)
       |> SampleApp.Repo.preload(:microposts)
    if user do
    render(conn, "show.html", user: user)
  else
    conn
    |> put_flash(:error, "User not found")
    |> redirect(to: "/")
  end
end


  def new(conn, _params) do
    user= conn.assigns[:current_user]

    changeset= Microposts.change_micropost(%Micropost{})
    render(conn, "new.html", changeset: changeset, user: user)
  end

  def create(conn, %{"micropost"=> micropost_params}) do
    user_id=conn.assigns[:current_user].id
    IO.inspect(user_id)
    micropost_params=Map.put(micropost_params,"user_id", user_id)

    case Microposts.create_micropost(micropost_params) do
      {:ok, _micropost} ->
        conn
        |> put_flash(:info, "Micropost created successfully")
        |> redirect(to: ~p"/users/#{user_id}/microposts")
      {:error, %Ecto.Changeset{}= changeset}->
        render(conn, "new.html", changeset: changeset)

    end

  end

  def delete(conn, %{"id"=> id}) do
    case Microposts.get_micropost!(id) do
    nil ->
      conn
      |> put_flash(:error,"Micropost doesnt exists")
      |> redirect(to: ~p"/users/#{conn.assigns[:current_user].id}")

      micropost ->
      if micropost.user_id==conn.assigns[:current_user].id do
     {:ok, _}= Microposts.delete_micropost(micropost)
     conn
     |> put_flash(:info, "Micropost deleted succesfully")
     |> redirect(to: ~p"/users/#{conn.assigns[:current_user].id}")
    else
      conn
      |> put_flash(:error, "you cant delete this micropost")
      |> redirect(to: ~p"/users/#{conn.assigns[:current_user].id}")
    end
    end


  end
end
