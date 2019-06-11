defmodule PurlexWeb.UserView do
  use PurlexWeb, :view
  alias Purlex.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
