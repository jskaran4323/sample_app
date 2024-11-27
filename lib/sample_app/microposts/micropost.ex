defmodule SampleApp.Microposts.Micropost do
  use Ecto.Schema
  import Ecto.Changeset

  schema "microposts" do
    field :content, :string
    belongs_to :user, SampleApp.Accounts.User
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(micropost, attrs) do
    micropost
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
