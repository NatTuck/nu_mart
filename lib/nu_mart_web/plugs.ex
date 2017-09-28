defmodule NuMartWeb.Plugs do
  import Plug.Conn

  def fetch_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = NuMart.Accounts.get_user!(user_id)
      assign(conn, :user, user)
    else
      assign(conn, :user, nil)
    end
  end

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
