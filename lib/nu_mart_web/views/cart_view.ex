defmodule NuMartWeb.CartView do
  use NuMartWeb, :view

  def total_price(cart) do
    Enum.reduce cart.cart_items, 0, fn item, acc ->
      acc + item.count * Decimal.to_float(item.product.price)
    end
  end
end
