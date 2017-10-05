defmodule NuMartWeb.ReviewControllerTest do
  use NuMartWeb.ConnCase

  alias NuMart.Shop
  alias NuMart.Accounts
  alias NuMart.Feedback
  alias NuMart.Feedback.Review

  def valid_attrs(:review) do
    {:ok, prod}   = Shop.create_product(%{name: "foo", desc: "bar", price: Decimal.new("5.00")})
    {:ok, user}   = Accounts.create_user(%{email: "alice@example.com"})
    %{comment: "some comment", stars: 42, user_id: user.id, product_id: prod.id}
  end

  def fixture(:review) do
    {:ok, review} = Feedback.create_review(valid_attrs(:review))
    review
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reviews", %{conn: conn} do
      conn = get conn, review_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create review" do
    test "renders review when data is valid", %{conn: conn} do
      conn = post conn, review_path(conn, :create), review: valid_attrs(:review)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, review_path(conn, :show, id)
      resp = assert json_response(conn, 200)["data"]
      assert resp["stars"] == 42
      assert resp["comment"] == "some comment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, review_path(conn, :create), review: %{"product_id" => -1}
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update review" do
    setup [:create_review]

    test "renders review when data is valid", %{conn: conn, review: %Review{id: id} = review} do
      conn = put conn, review_path(conn, :update, review), review: %{"stars" => 17}
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, review_path(conn, :show, id)
      resp = json_response(conn, 200)["data"]
      assert resp["stars"] == 17
    end

    test "renders errors when data is invalid", %{conn: conn, review: review} do
      conn = put conn, review_path(conn, :update, review), review: %{"stars" => ""}
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete review" do
    setup [:create_review]

    test "deletes chosen review", %{conn: conn, review: review} do
      conn = delete conn, review_path(conn, :delete, review)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, review_path(conn, :show, review)
      end
    end
  end

  defp create_review(_) do
    review = fixture(:review)
    {:ok, review: review}
  end
end
