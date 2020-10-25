defmodule Linx.Data.LinkTest do
  use ExUnit.Case

  alias Linx.Data.Link

  setup do
    Link.cleanup()
    :ok
  end

  describe "#struct" do
    test "creates a struct" do
      assert %Link{}
    end
  end

  describe "#create!" do
    test "returns a short_url" do
      assert address_hash = Link.create!("http://bing.com/asdf")
      assert address_hash == "8IZr1b"
    end
  end

  describe "#lookup" do
    test "returns a payload" do
      address_base = "http://bong.com/qwer"
      assert address_hash = Link.create!(address_base)
      assert payload = Link.lookup(address_hash)
      assert payload.url_hash == address_hash
      assert payload.url_base == address_base
      assert payload.url_base != address_hash
    end

    test "increments the use_count" do
      address_base = "http://asdf.com/xzcv"
      assert address_hash = Link.create!(address_base)
      assert payload = Link.lookup(address_hash)
      assert payload.ts_last_use != payload.ts_creation
      assert payload.use_count == 1
      assert payload2 = Link.lookup(address_hash)
      assert payload2.use_count == 2
    end
  end


  describe "#all" do
    test "returns a payload" do
      address_base = "http://bong.com/qwer"
      # assert address_hash = Link.create!(address_base)
      assert Link.create!(address_base)
      assert Link.all()
    end
  end
end
