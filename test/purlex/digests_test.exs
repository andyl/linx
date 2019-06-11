defmodule Purlex.DigestsTest do
  use ExUnit.Case, async: true
  alias Purlex.Digests

  describe "#get_links" do
    test "returns a value" do
      assert Digests.get_links()
    end
  end

  describe "#get_link" do
    test "returns a value" do
      assert Digests.get_link(1)
    end

    test "returns no value with a bad ID" do
      refute Digests.get_link(10)
    end
  end
end
