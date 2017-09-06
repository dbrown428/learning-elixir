defmodule KV.Supervisor do
  use Supervisor

  def start_link(options) do
    Supervisor.start_link(__MODULE__, :ok, options)
  end

  def init(:ok) do
    children = [
      # Instead of passing the registry PID around we will give the registry
      # a name (since we only have one), so we can easily reference it by its
      # name.
      {KV.Registry, name: KV.Registry},
      # or
      # KV.Registry
      KV.BucketSupervisor
    ]

    # the supervision strategy dictates what happens when one of the children 
    # crashes. The supervisor retrieves all the child specifications and uses
    # that information to start the children in the order they were defined.
    Supervisor.init(children, strategy: :one_for_one)
  end
end