defmodule SampleApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
   @valid_email_regex ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password , :string , virtual: true
    field :password_confirmation , :string , virtual: true
    has_many :microposts, SampleApp.Microposts.Micropost

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password, :password_confirmation])
    |> validate_length(:name, max: 50)
    |> validate_length(:email, max: 255)
    |> validate_format(:email, @valid_email_regex)
    |> update_change(:email, &String.downcase/1)
     |> unique_constraint(:email)
    |> validate_length(:password, min: 6, max: 128)
    |> validate_confirmation(:password, message: "Passwords do not match")
    |> put_password_hash()
  end



   defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, password)

      _ ->
        changeset
    end
  end
end
