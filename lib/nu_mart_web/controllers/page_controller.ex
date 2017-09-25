defmodule NuMartWeb.PageController do
  use NuMartWeb, :controller

  def index(conn, _params) do
    redirect conn, to: product_path(conn, :index)
  end
end
