defmodule NuMart.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias NuMart.Accounts.User


  schema "users" do
    field :email, :string
    field :is_admin?, :boolean

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :is_admin?])
    |> validate_required([:email])
  end
end
