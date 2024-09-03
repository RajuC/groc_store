defmodule GrocStore.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :state, :string
    field :zip, :integer
    field :password, :string
    field :customer_id, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :address_one, :string
    field :address_two, :string, default: "NA"
    field :city, :string
    field :phone_number, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:customer_id, :first_name, :last_name, :email, :password, :address_one, :address_two, :city, :state, :zip, :phone_number])
    |> validate_required([:customer_id, :first_name, :last_name, :email, :password, :address_one, :address_two, :city, :state, :zip, :phone_number])
  end
end
