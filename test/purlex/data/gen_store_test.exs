defmodule Purelex.Data.GenStoreTest do
  use ExUnit.Case, async: true

  alias Purlex.Data.GenStore

  setup do
    GenStore.test_context()
  end

  describe "#start / #stop" do
    test "creates a table", ctx do
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.started?(ctx.tablekey)
      assert File.exists?(ctx.filepath)
      cleanup(ctx)
    end

    test "restarts with an existing filepath", ctx do
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.started?(ctx.tablekey)
      GenStore.stop(ctx.tablekey)
      refute GenStore.started?(ctx.tablekey)
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.started?(ctx.tablekey)
      cleanup(ctx)
    end
  end

  describe "#insert / #lookup" do
    test "sets and gets data", ctx do
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.insert(ctx.tablekey, {:asdf, 1})
      assert GenStore.lookup(ctx.tablekey, :asdf) == [asdf: 1]
      cleanup(ctx)
    end

    test "preserves data between restarts", ctx do
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.insert(ctx.tablekey, {:qwer, 1})
      assert GenStore.lookup(ctx.tablekey, :qwer) == [qwer: 1]
      GenStore.stop(ctx.tablekey)
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.lookup(ctx.tablekey, :qwer) == [qwer: 1]
      cleanup(ctx)
    end

    test "updates values", ctx do
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.insert(ctx.tablekey, {"asdf", 1})
      assert GenStore.lookup(ctx.tablekey, "asdf") == [{"asdf", 1}]
      assert GenStore.insert(ctx.tablekey, {"asdf", 2})
      assert GenStore.lookup(ctx.tablekey, "asdf") == [{"asdf", 2}]
      cleanup(ctx)
    end
  end

  describe "#stop" do
    test "cleans up the ETS tablekey and filepath", ctx do
      assert GenStore.start(ctx.tablekey, ctx.filepath)
      assert GenStore.started?(ctx.tablekey)
      assert File.exists?(ctx.filepath)
      cleanup(ctx)
      refute GenStore.started?(ctx.tablekey)
      refute File.exists?(ctx.filepath)
    end
  end

  describe "bag datastores" do
    test "stores all inserts", ctx do
      assert GenStore.start(ctx.tablekey, ctx.filepath, [:bag])
      assert GenStore.insert(ctx.tablekey, {"asdf", 1})
      assert GenStore.lookup(ctx.tablekey, "asdf") == [{"asdf", 1}]
      assert GenStore.insert(ctx.tablekey, {"asdf", 2})
      assert GenStore.lookup(ctx.tablekey, "asdf") == [{"asdf", 1}, {"asdf", 2}]
      cleanup(ctx)
    end
  end

  defp cleanup(ctx), do: GenStore.stop(ctx.tablekey, ctx.filepath)

end
