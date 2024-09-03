defmodule GrocStoreWeb.CustomerController do
  use GrocStoreWeb, :controller

  alias GrocStore.Accounts
  alias GrocStore.Accounts.Customer

  action_fallback(GrocStoreWeb.FallbackController)

  def new(conn, _params) do
    changeset = Accounts.change_customer(%Customer{})
    render(conn, :new, changeset: changeset)
  end

  def index(conn, _params) do
    customers = Accounts.list_customers()
    render(conn, :index, customers: customers)
  end

  def create_customer(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Accounts.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/customers/#{customer}")
      |> render(:show, customer: customer)
    end
  end

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Accounts.create_customer(customer_params) do
      conn
      |> put_flash(:info, "Customer Updated successfully.")
      |> render(:show, customer: customer)
    end
  end

  def edit(conn, %{"id" => id}) do
    customer = Accounts.get_customer!(id)
    changeset = Accounts.change_customer(customer)
    render(conn, :edit, customer: customer, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    customer = Accounts.get_customer!(id)
    render(conn, :show, customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Accounts.get_customer!(id)

    with {:ok, %Customer{} = customer} <- Accounts.update_customer(customer, customer_params) do
      conn
      |> put_flash(:info, "Customer Updated successfully.")
      |> render(:show, customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Accounts.get_customer!(id)

    with {:ok, %Customer{}} <- Accounts.delete_customer(customer) do
      conn
      |> put_flash(:info, "Customer Deleted successfully.")
      |> redirect(to: ~p"/customers/")
    end
  end
end
