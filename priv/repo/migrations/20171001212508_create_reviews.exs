defmodule NuMart.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :stars, :integer, null: false
      add :comment, :text, null: false
      add :product_id, references(:products, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:reviews, [:product_id])
    create index(:reviews, [:user_id])
  end
end
