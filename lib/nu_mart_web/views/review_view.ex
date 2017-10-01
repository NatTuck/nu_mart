defmodule NuMartWeb.ReviewView do
  use NuMartWeb, :view
  alias NuMartWeb.ReviewView

  def render("index.json", %{reviews: reviews}) do
    %{data: render_many(reviews, ReviewView, "review.json")}
  end

  def render("show.json", %{review: review}) do
    %{data: render_one(review, ReviewView, "review.json")}
  end

  def render("review.json", %{review: review}) do
    %{id: review.id,
      stars: review.stars,
      comment: review.comment}
  end
end
