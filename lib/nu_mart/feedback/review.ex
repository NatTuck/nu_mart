defmodule NuMart.Feedback.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias NuMart.Feedback.Review


  schema "reviews" do
    field :comment, :string
    field :stars, :integer
    field :product_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Review{} = review, attrs) do
    review
    |> cast(attrs, [:stars, :comment])
    |> validate_required([:stars, :comment])
  end
end
