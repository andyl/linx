defmodule Purlex.Data.LinkTest do
  use ExUnit.Case, async: true

  alias Purlex.Data.Link

  describe "#creation" do
    test "creates a struct" do
      assert %Link{}
    end
  end
end
