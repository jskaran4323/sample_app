defmodule SampleApp.AccountsTest do
  use SampleApp.DataCase

  alias SampleApp.Accounts

  describe "users" do
    alias SampleApp.Accounts.User

#     import SampleApp.AccountsFixtures

#     @invalid_attrs %{name: nil, email: nil}

#     test "list_users/0 returns all users" do
#       user = user_fixture()
#       assert Accounts.list_users() == [user]
#     end

#     test "get_user!/1 returns the user with given id" do
#       user = user_fixture()
#       assert Accounts.get_user!(user.id) == user
#     end


#     test "create_user/1 with valid data creates a user" do
#       valid_attrs = %{name: "some name", email: "some email"}

#       assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
#       assert user.name == "some name"
#       assert user.email == "some email"
#     end

#     test "create_user/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
#     end

#     test "update_user/2 with valid data updates the user" do
#       user = user_fixture()
#       update_attrs = %{name: "some updated name", email: "some updated email"}

#       assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
#       assert user.name == "some updated name"
#       assert user.email == "some updated email"
#     end

#     test "update_user/2 with invalid data returns error changeset" do
#       user = user_fixture()
#       assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
#       assert user == Accounts.get_user!(user.id)
#     end

#     test "delete_user/1 deletes the user" do
#       user = user_fixture()
#       assert {:ok, %User{}} = Accounts.delete_user(user)
#       assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
#     end

#     test "change_user/1 returns a user changeset" do
#       user = user_fixture()
#       assert %Ecto.Changeset{} = Accounts.change_user(user)
#     end
 end

 @valid_attrs %{
   name: "Example User",
   email: "user@example.com",
   password: "foobar",
   password_confirmation: "foobar"
 }
 ##Own Test
  describe "create_user/1" do


    alias SampleApp.Accounts.User

    import SampleApp.AccountsFixtures
    test "with valid attributes inserts user" do
    assert {:ok, %User{}}=Accounts.create_user(@valid_attrs)
    end
    test "name left blank does not insert user" do
      assert {:error, %Ecto.Changeset{}} =Accounts.create_user(
        %{@valid_attrs | name: "      "}
      )
    end
    test "Email left blank does not insert user" do
      assert {:error, %Ecto.Changeset{}}=Accounts.create_user(
        %{@valid_attrs | email: "   "}
      )
    end
    test "name too long to insert user" do
      assert{:error, %Ecto.Changeset{}}=Accounts.create_user(
        %{@valid_attrs | name: String.duplicate("a",51)}
      )
    end
    test "email too long does not insert user" do
      assert {:error, %Ecto.Changeset{}}=Accounts.create_user(
        %{@valid_attrs | email: String.duplicate("a",244)<> "@example.com"}
      )
    end
    test "valid email address insert user" do
      valid_addresses=["user@example.com", "USER@foo.COM",
        "A_US-ER@foo.bar.org", "first.last@foo.jp", "alice+bob@baz.cn"]
        for valid_address<- valid_addresses do
          assert{:ok , %User{}}=Accounts.create_user(%{
            @valid_attrs | email: valid_address
          })
        end
    end

    test "email address is inserted as lower-case" do
      mixed_case_email="Foo@ExAMPLe.CoM"
      assert{:ok, %User{email: "foo@example.com"}}=
        Accounts.create_user(%{
          @valid_attrs | email: mixed_case_email
        })
    end



  end

end
