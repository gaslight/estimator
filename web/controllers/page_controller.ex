defmodule Estimator.PageController do
  use Estimator.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
