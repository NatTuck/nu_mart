defmodule NuMartWeb.CartView do
  use NuMartWeb, :view

  def total_price(cart) do
    Enum.reduce cart.cart_items, 0, fn item, acc ->
      acc + item.count * Decimal.to_float(item.product.price)
    end
  end

  def cart_owner(cart) do
    if cart.user do
      cart.user.email
    else
      "none"
    end
  end
end
