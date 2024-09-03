defmodule GrocStoreWeb.CustomerJSON do
  alias GrocStore.Accounts.Customer

  @doc """
  Renders a list of customers.
  """
  def index(%{customers: customers}) do
    %{data: for(customer <- customers, do: data(customer))}
  end

  @doc """
  Renders a single customer.
  """
  def show(%{customer: customer}) do
    %{data: data(customer)}
  end

  defp data(%Customer{} = customer) do
    %{
      id: customer.id,
      customer_id: customer.customer_id,
      first_name: customer.first_name,
      last_name: customer.last_name,
      email: customer.email,
      address_one: customer.address_one,
      address_two: customer.address_two,
      city: customer.city,
      state: customer.state,
      zip: customer.zip,
      phone_number: customer.phone_number
    }
  end
end
