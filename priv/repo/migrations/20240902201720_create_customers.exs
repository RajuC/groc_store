defmodule GrocStore.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :customer_id, :integer
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password, :string
      add :address_one, :string
      add :address_two, :string
      add :city, :string
      add :state, :string
      add :zip, :integer
      add :phone_number, :string

      timestamps(type: :utc_datetime)
    end
  end
end
