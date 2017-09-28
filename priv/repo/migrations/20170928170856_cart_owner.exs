defmodule NuMart.Repo.Migrations.CartOwner do
  use Ecto.Migration

  def change do
    # Add user_id reference to carts table.
    alter table("carts") do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
