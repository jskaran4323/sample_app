defmodule SampleApp.MicropostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SampleApp.Microposts` context.
  """

  @doc """
  Generate a micropost.
  """
  def micropost_fixture(attrs \\ %{}) do
    {:ok, micropost} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> SampleApp.Microposts.create_micropost()

    micropost
  end
end
