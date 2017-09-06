defmodule KV.BucketTest do
  # Using async will allow multiple tests to run in parallel on multiple cores.
  # Only use async if the test case does not rely on or change any global values.
  # Eg. If the test writes to the filesystem or database, then keep it synchronous.
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = start_supervised(KV.Bucket)
    %{bucket: bucket}
  end
  
  # bucket comes from the setup block…
  test "stores value by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "delete value by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
    KV.Bucket.put(bucket, "milk", 3)
    
    value = KV.Bucket.delete(bucket, "milk")
    assert value == 3
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  @doc """
  When a supervisor restarts a new bucket, the registry does not about it.
  So we will have an empty bucket in the supervisor that nobody can access.
  Buckets should be temporary.

  If a bucket crashes, regardless of the reason, it should not be restarted.
  """
  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end
end