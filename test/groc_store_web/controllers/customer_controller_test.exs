defmodule GrocStoreWeb.CustomerControllerTest do
  use GrocStoreWeb.ConnCase

  import GrocStore.AccountsFixtures

  alias GrocStore.Accounts.Customer

  @create_attrs %{
    state: "some state",
    zip: 42,
    password: "some password",
    customer_id: 42,
    first_name: "some first_name",
    last_name: "some last_name",
    email: "some email",
    address_one: "some address_one",
    address_two: "some address_two",
    city: "some city",
    phone_number: "some phone_number"
  }
  @update_attrs %{
    state: "some updated state",
    zip: 43,
    password: "some updated password",
    customer_id: 43,
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    email: "some updated email",
    address_one: "some updated address_one",
    address_two: "some updated address_two",
    city: "some updated city",
    phone_number: "some updated phone_number"
  }
  @invalid_attrs %{state: nil, zip: nil, password: nil, customer_id: nil, first_name: nil, last_name: nil, email: nil, address_one: nil, address_two: nil, city: nil, phone_number: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customers", %{conn: conn} do
      conn = get(conn, ~p"/api/customers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create customer" do
    test "renders customer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/customers", customer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/customers/#{id}")

      assert %{
               "id" => ^id,
               "address_one" => "some address_one",
               "address_two" => "some address_two",
               "city" => "some city",
               "customer_id" => 42,
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "password" => "some password",
               "phone_number" => "some phone_number",
               "state" => "some state",
               "zip" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/customers", customer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update customer" do
    setup [:create_customer]

    test "renders customer when data is valid", %{conn: conn, customer: %Customer{id: id} = customer} do
      conn = put(conn, ~p"/api/customers/#{customer}", customer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/customers/#{id}")

      assert %{
               "id" => ^id,
               "address_one" => "some updated address_one",
               "address_two" => "some updated address_two",
               "city" => "some updated city",
               "customer_id" => 43,
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "password" => "some updated password",
               "phone_number" => "some updated phone_number",
               "state" => "some updated state",
               "zip" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, customer: customer} do
      conn = put(conn, ~p"/api/customers/#{customer}", customer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete customer" do
    setup [:create_customer]

    test "deletes chosen customer", %{conn: conn, customer: customer} do
      conn = delete(conn, ~p"/api/customers/#{customer}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/customers/#{customer}")
      end
    end
  end

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end
end
