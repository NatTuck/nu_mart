defmodule NuMartWeb.SessionController do
  use NuMartWeb, :controller

  alias NuMart.Accounts

  def login(conn, %{"user" => %{"email" => email}}) do
    user = Accounts.get_user_by_email(email)

    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.email}")
      |> redirect(to: product_path(conn, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "No such user")
      |> redirect(to: product_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: product_path(conn, :index))
  end
end
