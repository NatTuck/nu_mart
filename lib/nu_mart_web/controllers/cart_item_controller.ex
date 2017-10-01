defmodule NuMartWeb.CartItemController do
  use NuMartWeb, :controller

  alias NuMart.Shop
  alias NuMart.Shop.CartItem

  def index(conn, _params) do
    cart_items = Shop.list_cart_items()
    render(conn, "index.html", cart_items: cart_items)
  end

  def new(conn, _params) do
    changeset = Shop.change_cart_item(%CartItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cart_item" => cart_item_params}) do
    case Shop.create_cart_item(cart_item_params) do
      {:ok, cart_item} ->
        cart_item = NuMart.Repo.preload(cart_item, :product)

        conn
        |> put_flash(:info, "Added #{cart_item.product.name} to cart.")
        |> redirect(to: product_path(conn, :show, cart_item.product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cart_item = Shop.get_cart_item!(id)
    render(conn, "show.html", cart_item: cart_item)
  end

  def edit(conn, %{"id" => id}) do
    cart_item = Shop.get_cart_item!(id)
    changeset = Shop.change_cart_item(cart_item)
    render(conn, "edit.html", cart_item: cart_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cart_item" => cart_item_params}) do
    cart_item = Shop.get_cart_item!(id)

    case Shop.update_cart_item(cart_item, cart_item_params) do
      {:ok, cart_item} ->
        conn
        |> put_flash(:info, "Cart item updated successfully.")
        |> redirect(to: cart_item_path(conn, :show, cart_item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cart_item: cart_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cart_item = Shop.get_cart_item!(id)
    {:ok, _cart_item} = Shop.delete_cart_item(cart_item)

    conn
    |> put_flash(:info, "Cart item deleted successfully.")
    |> redirect(to: NavigationHistory.last_path(conn, default: product_path(conn, :index)))
  end
end
