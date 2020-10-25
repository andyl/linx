defmodule Linx.Data.LogTest do
  use ExUnit.Case

  alias Linx.Data.Log

  describe "#creation" do
    test "creates a struct" do
      assert %Log{}
    end
  end
end
