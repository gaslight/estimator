defmodule Estimator.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  require IEx

  use Estimator.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IEx.pry
    # redirect_url = conn |> Plug.Conn.get_req_header("referer") |> hd
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> put_session(:current_user, %{id: auth.uid, name: auth.info.name})
    |> redirect(to: "/")
  end
end
