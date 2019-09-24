defmodule Linkex.Data.LogTest do
  use ExUnit.Case

  alias Linkex.Data.Log

  describe "#creation" do
    test "creates a struct" do
      assert %Log{}
    end
  end
end
