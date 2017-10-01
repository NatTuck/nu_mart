defmodule NuMartWeb.CartController do
  use NuMartWeb, :controller

  alias NuMart.Shop
  alias NuMart.Shop.Cart

  def index(conn, _params) do
    carts = Shop.list_carts()
    render(conn, "index.html", carts: carts)
  end

  def new(conn, _params) do
    changeset = Shop.change_cart(%Cart{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cart" => cart_params}) do
    case Shop.create_cart(cart_params) do
      {:ok, cart} ->
        conn
        |> put_flash(:info, "Cart created successfully.")
        |> redirect(to: cart_path(conn, :show, cart))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cart = Shop.get_cart!(id) |> NuMart.Repo.preload([:user, {:cart_items, :product}])
    render(conn, "show.html", cart: cart)
  end

  def edit(conn, %{"id" => id}) do
    cart = Shop.get_cart!(id)
    changeset = Shop.change_cart(cart)
    render(conn, "edit.html", cart: cart, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cart" => cart_params}) do
    cart = Shop.get_cart!(id)

    case Shop.update_cart(cart, cart_params) do
      {:ok, cart} ->
        conn
        |> put_flash(:info, "Cart updated successfully.")
        |> redirect(to: cart_path(conn, :show, cart))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cart: cart, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cart = Shop.get_cart!(id)
    {:ok, _cart} = Shop.delete_cart(cart)

    conn
    |> put_flash(:info, "Cart deleted successfully.")
    |> redirect(to: cart_path(conn, :index))
  end
end
