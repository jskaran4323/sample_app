defmodule SampleAppWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use SampleAppWeb, :controller` and
  `use SampleAppWeb, :live_view`.
  """
  use SampleAppWeb, :html

  embed_templates "layouts/*"

  def header(assigns) do

    ~H"""
    <header>
      <nav class="bg-gray-900 text-white fixed top-0 w-full shadow-md">
        <div class="container mx-auto flex items-center justify-between px-4 py-3">
          <.link
            navigate={~p"/"}
            id="logo"
            class="text-2xl font-bold uppercase hover:text-gray-300"
          >
            Sample App
          </.link>
          <button
            class="text-white md:hidden"
            type="button"
            aria-label="Toggle navigation"
            onclick="document.getElementById('navbarNav').classList.toggle('hidden')"
          >
            <svg
              class="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16"
              >
              </path>
            </svg>
          </button>
          <div id="navbarNav" class="hidden md:flex md:items-center space-x-4">
            <ul class="flex space-x-4">
              <li class="nav-item">
                <.link navigate={~p"/"} class="hover:text-gray-300">Home</.link>
              </li>
              <li class="nav-item">
                <.link navigate={~p"/help"} class="hover:text-gray-300">Help</.link>
              </li>
             <li class="nav-item">


               <%= if assigns[:current_user] do %>
               <li>
             <.link
               navigate={~p"/logout"} method="delete"   class="hover:text-gray-300"
               >
              Log out
            </.link>
          </li>
        <% else %>
          <li>
      <.link navigate={~p"/login"} class="hover:text-gray-300">
      Login
       </.link>
       </li>
         <% end %>

            </li>
            </ul>
          </div>
        </div>
      </nav>
    </header>
    """
  end

  def footer(assigns) do
    ~H"""
    <footer class="footer">
      <div class="container">
        <small>
          The <a href="#">Phoenix SampleApp</a>
          <a href="#"></a>
        </small>
        <nav>
          <ul>
            <li>
              <.link navigate={~p"/about"} class="hover:text-gray-300">
                About
              </.link>
            </li>
            <li><.link navigate={~p"/contact"}>Contact</.link></li>
          </ul>
        </nav>
      </div>
    </footer>
    """
  end
end
