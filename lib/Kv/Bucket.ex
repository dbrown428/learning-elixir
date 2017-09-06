defmodule KV.Bucket do
  use Agent, restart: :temporary

  # Start a new bucket
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  def get(bucket, key) do
    retrieveByKey = fn dict -> Map.get(dict, key) end

    # Or use the function capture approach…
    # retrieveByKey = &Map.get(&1, key)

    # Get a value from the bucket by key.
    Agent.get(bucket, retrieveByKey)
  end

  def put(bucket, key, value) do
    putByKey = fn dict -> Map.put(dict, key, value) end
    Agent.update(bucket, putByKey)

    # Or use the function capture approach…
    # Agent.update(bucket, &Map.put(&1, key, value))
  end

  def delete(bucket, key) do
    # everything inside the function we passed to the agent, happens in the agent
    # process. In this case, the agent is receiving and responding to our messages,
    # so we say the agent process is the server.
    # Everything outside the function is happening in the client.
    Agent.get_and_update(bucket, fn dict -> 
      Map.pop(dict, key)
    end)

    # Or use the function capture approach…
    # Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end