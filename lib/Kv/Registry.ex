defmodule KV.Registry do
  use GenServer

  ## Client API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Make an asynchronoush call to the server, telling it to create an entry
  with the specified name.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  ## Server Callbacks

  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @doc """
  There are two types of requests you can send to a GenServer: calls and casts.
  Calls are synchronous and the server must send a response back to such a
  request. Casts are asynchronous and the server won't send a response back.

  Requests are often specified as tuples. It's common to specify the action 
  being request as the first element of the tuple, and arguments for that
  action in the remaining elements.
  """
  def handle_call({:lookup, name}, _from, {names, _} = state) do
    {:reply, Map.fetch(names, name), state}
  end

  @doc """
  Use links when you want linked crashes, and monitors when you just want to be
  informed of crashes, exits, and so on.
  """
  def handle_cast({:create, name}, {names, refs}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, refs}}
    else
      # This is a bad idea, as this will link crashes. Eg. If the bucket 
      # crashes it will take down the registry too. Avoid creating new
      # processes directly, instead, delegate this responsibility to the
      # supervisors.
      # {:ok, pid} = KV.Bucket.start_link([])

      {:ok, pid} = KV.BucketSupervisor.start_bucket()
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, pid)
      {:noreply, {names, refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  @doc """
  There's a chance that unexpected messages will arrive to the server, and 
  could cause the registry to crash if we don't handle them.
  In this case, we're just defining a catch-all.
  """
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end