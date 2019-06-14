defmodule Purlex.Data.LogTest do
  use ExUnit.Case, async: true

  alias Purlex.Data.Log

  describe "#creation" do
    test "creates a struct" do
      assert %Log{}
    end
  end
end
