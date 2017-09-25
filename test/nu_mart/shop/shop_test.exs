defmodule NuMart.ShopTest do
  use NuMart.DataCase

  alias NuMart.Shop

  describe "products" do
    alias NuMart.Shop.Product

    @valid_attrs %{desc: "some desc", name: "some name", price: "120.5"}
    @update_attrs %{desc: "some updated desc", name: "some updated name", price: "456.7"}
    @invalid_attrs %{desc: nil, name: nil, price: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shop.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Shop.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Shop.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Shop.create_product(@valid_attrs)
      assert product.desc == "some desc"
      assert product.name == "some name"
      assert product.price == Decimal.new("120.5")
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Shop.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.desc == "some updated desc"
      assert product.name == "some updated name"
      assert product.price == Decimal.new("456.7")
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_product(product, @invalid_attrs)
      assert product == Shop.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Shop.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Shop.change_product(product)
    end
  end

  describe "carts" do
    alias NuMart.Shop.Cart

    @valid_attrs %{cart_type: "some cart_type"}
    @update_attrs %{cart_type: "some updated cart_type"}
    @invalid_attrs %{cart_type: nil}

    def cart_fixture(attrs \\ %{}) do
      {:ok, cart} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shop.create_cart()

      cart
    end

    test "list_carts/0 returns all carts" do
      cart = cart_fixture()
      assert Shop.list_carts() == [cart]
    end

    test "get_cart!/1 returns the cart with given id" do
      cart = cart_fixture()
      assert Shop.get_cart!(cart.id) == cart
    end

    test "create_cart/1 with valid data creates a cart" do
      assert {:ok, %Cart{} = cart} = Shop.create_cart(@valid_attrs)
      assert cart.cart_type == "some cart_type"
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_cart(@invalid_attrs)
    end

    test "update_cart/2 with valid data updates the cart" do
      cart = cart_fixture()
      assert {:ok, cart} = Shop.update_cart(cart, @update_attrs)
      assert %Cart{} = cart
      assert cart.cart_type == "some updated cart_type"
    end

    test "update_cart/2 with invalid data returns error changeset" do
      cart = cart_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_cart(cart, @invalid_attrs)
      assert cart == Shop.get_cart!(cart.id)
    end

    test "delete_cart/1 deletes the cart" do
      cart = cart_fixture()
      assert {:ok, %Cart{}} = Shop.delete_cart(cart)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_cart!(cart.id) end
    end

    test "change_cart/1 returns a cart changeset" do
      cart = cart_fixture()
      assert %Ecto.Changeset{} = Shop.change_cart(cart)
    end
  end

  describe "cart_items" do
    alias NuMart.Shop.CartItem

    @valid_attrs %{count: 42}
    @update_attrs %{count: 43}
    @invalid_attrs %{count: nil}

    def cart_item_fixture(attrs \\ %{}) do
      {:ok, cart_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shop.create_cart_item()

      cart_item
    end

    test "list_cart_items/0 returns all cart_items" do
      cart_item = cart_item_fixture()
      assert Shop.list_cart_items() == [cart_item]
    end

    test "get_cart_item!/1 returns the cart_item with given id" do
      cart_item = cart_item_fixture()
      assert Shop.get_cart_item!(cart_item.id) == cart_item
    end

    test "create_cart_item/1 with valid data creates a cart_item" do
      assert {:ok, %CartItem{} = cart_item} = Shop.create_cart_item(@valid_attrs)
      assert cart_item.count == 42
    end

    test "create_cart_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_cart_item(@invalid_attrs)
    end

    test "update_cart_item/2 with valid data updates the cart_item" do
      cart_item = cart_item_fixture()
      assert {:ok, cart_item} = Shop.update_cart_item(cart_item, @update_attrs)
      assert %CartItem{} = cart_item
      assert cart_item.count == 43
    end

    test "update_cart_item/2 with invalid data returns error changeset" do
      cart_item = cart_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_cart_item(cart_item, @invalid_attrs)
      assert cart_item == Shop.get_cart_item!(cart_item.id)
    end

    test "delete_cart_item/1 deletes the cart_item" do
      cart_item = cart_item_fixture()
      assert {:ok, %CartItem{}} = Shop.delete_cart_item(cart_item)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_cart_item!(cart_item.id) end
    end

    test "change_cart_item/1 returns a cart_item changeset" do
      cart_item = cart_item_fixture()
      assert %Ecto.Changeset{} = Shop.change_cart_item(cart_item)
    end
  end
end
