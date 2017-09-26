defmodule NuMart.Shop.CartItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias NuMart.Shop.CartItem


  schema "cart_items" do
    field :count, :integer
    belongs_to :cart, NuMart.Shop.Cart 
    belongs_to :product, NuMart.Shop.Product

    timestamps()
  end

  @doc false
  def changeset(%CartItem{} = cart_item, attrs) do
    cart_item
    |> cast(attrs, [:count, :cart_id, :product_id])
    |> validate_required([:count, :cart_id, :product_id])
  end
end
