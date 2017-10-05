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
    data = %{
      id: review.id,
      stars: review.stars,
      comment: review.comment,
      product_id: review.product_id,
    }

    if Ecto.assoc_loaded?(review.user) do
      Map.put(data, :user_email, review.user.email)
    else
      data
    end
  end
end
