defmodule GrocStore.AccountsTest do
  use GrocStore.DataCase

  alias GrocStore.Accounts

  describe "customers" do
    alias GrocStore.Accounts.Customer

    import GrocStore.AccountsFixtures

    @invalid_attrs %{state: nil, zip: nil, password: nil, customer_id: nil, first_name: nil, last_name: nil, email: nil, address_one: nil, address_two: nil, city: nil, phone_number: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Accounts.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Accounts.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{state: "some state", zip: 42, password: "some password", customer_id: 42, first_name: "some first_name", last_name: "some last_name", email: "some email", address_one: "some address_one", address_two: "some address_two", city: "some city", phone_number: "some phone_number"}

      assert {:ok, %Customer{} = customer} = Accounts.create_customer(valid_attrs)
      assert customer.state == "some state"
      assert customer.zip == 42
      assert customer.password == "some password"
      assert customer.customer_id == 42
      assert customer.first_name == "some first_name"
      assert customer.last_name == "some last_name"
      assert customer.email == "some email"
      assert customer.address_one == "some address_one"
      assert customer.address_two == "some address_two"
      assert customer.city == "some city"
      assert customer.phone_number == "some phone_number"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{state: "some updated state", zip: 43, password: "some updated password", customer_id: 43, first_name: "some updated first_name", last_name: "some updated last_name", email: "some updated email", address_one: "some updated address_one", address_two: "some updated address_two", city: "some updated city", phone_number: "some updated phone_number"}

      assert {:ok, %Customer{} = customer} = Accounts.update_customer(customer, update_attrs)
      assert customer.state == "some updated state"
      assert customer.zip == 43
      assert customer.password == "some updated password"
      assert customer.customer_id == 43
      assert customer.first_name == "some updated first_name"
      assert customer.last_name == "some updated last_name"
      assert customer.email == "some updated email"
      assert customer.address_one == "some updated address_one"
      assert customer.address_two == "some updated address_two"
      assert customer.city == "some updated city"
      assert customer.phone_number == "some updated phone_number"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_customer(customer, @invalid_attrs)
      assert customer == Accounts.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Accounts.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Accounts.change_customer(customer)
    end
  end
end
