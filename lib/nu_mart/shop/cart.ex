defmodule NuMart.Shop.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  alias NuMart.Shop.Cart
  alias NuMart.Shop.CartItem

  schema "carts" do
    field :cart_type, :string
    has_many :cart_items, CartItem

    timestamps()
  end

  @doc false
  def changeset(%Cart{} = cart, attrs) do
    cart
    |> cast(attrs, [:cart_type])
    |> validate_required([:cart_type])
  end
end
