defmodule SampleAppWeb.Plugs.FetchCurrentUser do
  import Plug.Conn
  alias SampleApp.Repo
  alias SampleApp.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    if user_id do

      user = Accounts.get_user!(user_id) |> Repo.preload(:microposts)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end
