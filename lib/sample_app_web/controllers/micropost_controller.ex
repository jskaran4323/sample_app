defmodule SampleAppWeb.MicropostController do
  use SampleAppWeb, :controller
  alias SampleApp.Microposts
  alias SampleApp.Microposts.Micropost

  plug SampleAppWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  def new(conn, _params) do
    user= conn.assigns[:current_user]
    changeset= Microposts.change_micropost(%Micropost{})
    render(conn, "new.html", changeset: changeset, user: user)
  end
  def create(conn, %{"micropost"=> micropost_params}) do
    user_id=conn.assigns[:current_user].id
    micropost_params=Map.put(micropost_params,"user_id", user_id)

    case Microposts.create_micropost(micropost_params) do
      {:ok, _micropost} ->
        conn
        |> put_flash(:info, "Micropost created successfully")
        |> redirect(to: ~p"/users/#{user_id}")
      {:error, %Ecto.Changeset{}= changeset}->
        render(conn, "new.html", changeset: changeset)

    end

  end

  def delete(conn, %{"id"=> id}) do
    micropost= Microposts.get_micropost!(id)

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
