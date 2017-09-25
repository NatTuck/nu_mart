defmodule NuMartWeb.CartItemControllerTest do
  use NuMartWeb.ConnCase

  alias NuMart.Shop

  @create_attrs %{count: 42}
  @update_attrs %{count: 43}
  @invalid_attrs %{count: nil}

  def fixture(:cart_item) do
    {:ok, cart_item} = Shop.create_cart_item(@create_attrs)
    cart_item
  end

  describe "index" do
    test "lists all cart_items", %{conn: conn} do
      conn = get conn, cart_item_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Cart items"
    end
  end

  describe "new cart_item" do
    test "renders form", %{conn: conn} do
      conn = get conn, cart_item_path(conn, :new)
      assert html_response(conn, 200) =~ "New Cart item"
    end
  end

  describe "create cart_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, cart_item_path(conn, :create), cart_item: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == cart_item_path(conn, :show, id)

      conn = get conn, cart_item_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Cart item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, cart_item_path(conn, :create), cart_item: @invalid_attrs
      assert html_response(conn, 200) =~ "New Cart item"
    end
  end

  describe "edit cart_item" do
    setup [:create_cart_item]

    test "renders form for editing chosen cart_item", %{conn: conn, cart_item: cart_item} do
      conn = get conn, cart_item_path(conn, :edit, cart_item)
      assert html_response(conn, 200) =~ "Edit Cart item"
    end
  end

  describe "update cart_item" do
    setup [:create_cart_item]

    test "redirects when data is valid", %{conn: conn, cart_item: cart_item} do
      conn = put conn, cart_item_path(conn, :update, cart_item), cart_item: @update_attrs
      assert redirected_to(conn) == cart_item_path(conn, :show, cart_item)

      conn = get conn, cart_item_path(conn, :show, cart_item)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, cart_item: cart_item} do
      conn = put conn, cart_item_path(conn, :update, cart_item), cart_item: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Cart item"
    end
  end

  describe "delete cart_item" do
    setup [:create_cart_item]

    test "deletes chosen cart_item", %{conn: conn, cart_item: cart_item} do
      conn = delete conn, cart_item_path(conn, :delete, cart_item)
      assert redirected_to(conn) == cart_item_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, cart_item_path(conn, :show, cart_item)
      end
    end
  end

  defp create_cart_item(_) do
    cart_item = fixture(:cart_item)
    {:ok, cart_item: cart_item}
  end
end
