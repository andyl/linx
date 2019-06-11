defmodule Purlex.Digests do

  def get_link(id) do
    get_links()
    |> Enum.find(&(&1.id == id))
  end

  def get_links do
    [
      %{id: 1, key: "asdf", url: "http://bing.com", count: 0},
      %{id: 2, key: "qwer", url: "http://bong.com", count: 0},
      %{id: 3, key: "zxcv", url: "http://ting.com", count: 0},
    ]
  end
end
