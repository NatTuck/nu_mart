defmodule NuMart.Shop.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  alias NuMart.Shop.Cart


  schema "carts" do
    field :cart_type, :string
    belongs_to :user, NuMart.Accounts.User
    has_many :cart_items, NuMart.Shop.CartItem

    timestamps()
  end

  @doc false
  def changeset(%Cart{} = cart, attrs) do
    cart
    |> cast(attrs, [:cart_type, :user_id])
    |> validate_required([:cart_type])
  end
end
