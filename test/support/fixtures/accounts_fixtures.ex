defmodule GrocStore.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GrocStore.Accounts` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        address_one: "some address_one",
        address_two: "some address_two",
        city: "some city",
        customer_id: 42,
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "some password",
        phone_number: "some phone_number",
        state: "some state",
        zip: 42
      })
      |> GrocStore.Accounts.create_customer()

    customer
  end
end
