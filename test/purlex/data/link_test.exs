defmodule Purlex.Data.LinkTest do
  use ExUnit.Case, async: true

  alias Purlex.Data.Link
  alias Purlex.Data.GenStore

  setup do
    GenStore.test_context()
  end

  describe "#struct" do
    test "creates a struct" do
      assert %Link{}
    end
  end

  describe "#create" do
    test "returns a short_url", ctx do
      assert short_url = Link.create("http://bing.com/asdf", ctx)
      assert short_url == "http://mysite.com/8IZr1"
      cleanup(ctx)
    end
  end

  describe "#lookup" do
    test "returns a payload", ctx do
      base_url = "http://bong.com/qwer"
      assert hash_url = Link.create(base_url, ctx)
      assert payload = Link.lookup(hash_url, ctx)
      assert payload.hash_url == hash_url
      assert payload.base_url == base_url
      assert payload.base_url != hash_url
      cleanup(ctx)
    end

    test "increments the use_count", ctx do
      base_url = "http://asdf.com/xzcv"
      assert hash_url = Link.create(base_url, ctx)
      assert payload = Link.lookup(hash_url, ctx)
      assert payload.ts_last_use != payload.ts_creation
      assert payload.use_count == 1
      assert payload2 = Link.lookup(hash_url, ctx)
      assert payload2.use_count == 2
      cleanup(ctx)
    end
  end

  defp cleanup(ctx), do: GenStore.stop(ctx.tablekey, ctx.filepath)
end
