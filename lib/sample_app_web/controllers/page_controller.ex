defmodule SampleAppWeb.PageController do
  use SampleAppWeb, :controller

  def home(conn, _params) do

    render(conn, :home, layout: false)
  end
    def hello(conn, _params) do
    html(conn,"hello World!")
  end
end
