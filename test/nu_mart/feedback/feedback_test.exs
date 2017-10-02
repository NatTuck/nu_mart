defmodule NuMart.FeedbackTest do
  use NuMart.DataCase

  alias NuMart.Feedback

  describe "reviews" do
    alias NuMart.Feedback.Review

    @valid_attrs %{comment: "some comment", stars: 42}
    @update_attrs %{comment: "some updated comment", stars: 43}
    @invalid_attrs %{comment: nil, stars: nil}

    def review_fixture(attrs \\ %{}) do
      {:ok, review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feedback.create_review()

      review
    end

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Feedback.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Feedback.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      assert {:ok, %Review{} = review} = Feedback.create_review(@valid_attrs)
      assert review.comment == "some comment"
      assert review.stars == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feedback.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      assert {:ok, review} = Feedback.update_review(review, @update_attrs)
      assert %Review{} = review
      assert review.comment == "some updated comment"
      assert review.stars == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Feedback.update_review(review, @invalid_attrs)
      assert review == Feedback.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Feedback.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Feedback.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Feedback.change_review(review)
    end
  end
end
