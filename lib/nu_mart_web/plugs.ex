defmodule NuMartWeb.Plugs do
  import Plug.Conn

  # get_or_create_cart should be in the context module
  def get_or_create_cart(nil) do
    NuMart.Repo.insert!(%NuMart.Shop.Cart{})
  end

  def get_or_create_cart(cart_id) do
    cart = NuMart.Repo.get(NuMart.Shop.Cart, cart_id)
    if cart do
      cart
    else
      NuMart.Repo.insert!(%NuMart.Shop.Cart{})
    end
  end

  def fetch_cart(conn, _opts) do
    cart_id = get_session(conn, :cart_id)
    cart = get_or_create_cart(cart_id)
      |> NuMart.Repo.preload([cart_items: :product])
    conn
    |> put_session(:cart_id, cart.id)
    |> assign(:cart, cart)
  end
end
