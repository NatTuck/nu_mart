# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NuMart.Repo.insert!(%NuMart.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NuMart.Repo
alias Decimal, as: D

alias NuMart.Accounts.User
Repo.delete_all(User)

Repo.insert!(%User{email: "admin@example.com", is_admin?: true})
Repo.insert!(%User{email: "nat@example.com",   is_admin?: false})

alias NuMart.Shop.Product
Repo.delete_all(Product)

Repo.insert!(%Product{name: "Fidget Spinner", price: D.new("3000"),
  desc: "A waste of a ball bearing."})
Repo.insert!(%Product{name: "Hoverboard", price: D.new("120"), desc: "Free battery fire." })
Repo.insert!(%Product{name: "Pet Rock", price: D.new("49.99"), desc: "It's a rock." })
Repo.insert!(%Product{name: "Furby", price: D.new("89.99"), desc: "A terrifying monster."})
Repo.insert!(%Product{name: "Yo-Yo", price: D.new("3.49"), desc: "Some sort of weapon?" })
Repo.insert!(%Product{name: "Slinky", price: D.new("5.75"), desc: "Warn-out spring." })




