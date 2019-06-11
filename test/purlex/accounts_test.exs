defmodule Purlex.AccountsTest do
  use ExUnit.Case, async: true
  alias Purlex.Accounts

  describe "#accounts" do
    test "returns a value" do
      assert Accounts.users()
    end
  end

  describe "#account" do
    test "returns a value" do
      assert Accounts.user(1)
    end

    test "returns no value with a bad ID" do
      refute Accounts.user(10)
    end
  end
end
