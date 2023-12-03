defmodule KdsTreningyWeb.CalendarController do
  use KdsTreningyWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end

