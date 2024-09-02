defmodule GrocStore.Repo do
  use Ecto.Repo,
    otp_app: :groc_store,
    adapter: Ecto.Adapters.SQLite3
end
