defmodule NuMart.Feedback.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias NuMart.Feedback.Review

  schema "reviews" do
    field :comment, :string
    field :stars, :integer
    belongs_to :product, NuMart.Store.Product
    belongs_to :user, NuMart.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Review{} = review, attrs) do
    review
    |> cast(attrs, [:stars, :comment, :user_id, :product_id])
    |> validate_required([:stars, :comment, :user_id, :product_id])
  end
end
