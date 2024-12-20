defmodule SampleApp.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias SampleApp.Repo

  alias SampleApp.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def user_name(name) do
  Repo.get_by(User, name: name)
  end
  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
  @doc """
  deletes all users from the database
  """
  def delete_all_users do
    Repo.delete_all(User)
  end

  @doc"""
  Retrieves a user by email and password
  """
def get_user_by_email_password(email, password) do
  user = Repo.get_by(User, email: email)

  if user do
    IO.inspect(user.password_hash, label: "Stored Password")
    IO.inspect(password, label: "Provided Password")

    if user.password_hash == password do
      {:ok, user}
    else
      {:error, "Invalid credentials"}
    end
  else
    {:error, "Invalid credentials"}
  end
end
    
    @doc """
  Creates a changeset for login validations.
  """
  def change_user_login(attrs \\ %{}) do
    Ecto.Changeset.cast(%User{}, attrs, [:email, :password])
    |> Ecto.Changeset.validate_required([:email, :password])
  end
end
