defmodule NuMart.Repo.Migrations.CreateCarts do
  use Ecto.Migration

  def change do
    create table(:carts) do
      add :cart_type, :string, null: false, default: "active"

      timestamps()
    end

  end
end
