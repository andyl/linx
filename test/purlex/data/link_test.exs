defmodule Purlex.Data.LinkTest do
  use ExUnit.Case, async: true

  alias Purlex.Data.Link

  setup do
    Pets.test_context()
  end

  describe "#struct" do
    test "creates a struct" do
      assert %Link{}
    end
  end

  describe "#create!" do
    test "returns a short_url", ctx do
      assert address_hash = Link.create!("http://bing.com/asdf", ctx)
      assert address_hash == "8IZr1b"
      cleanup(ctx)
    end
  end

  describe "#lookup" do
    test "returns a payload", ctx do
      address_base = "http://bong.com/qwer"
      assert address_hash = Link.create!(address_base, ctx)
      assert payload = Link.lookup(address_hash, ctx)
      assert payload.url_hash == address_hash
      assert payload.url_base == address_base
      assert payload.url_base != address_hash
      cleanup(ctx)
    end

    test "increments the use_count", ctx do
      address_base = "http://asdf.com/xzcv"
      assert address_hash = Link.create!(address_base, ctx)
      assert payload = Link.lookup(address_hash, ctx)
      assert payload.ts_last_use != payload.ts_creation
      assert payload.use_count == 1
      assert payload2 = Link.lookup(address_hash, ctx)
      assert payload2.use_count == 2
      cleanup(ctx)
    end
  end

  defp cleanup(ctx), do: Pets.stop(ctx.tablekey, ctx.filepath)
end
