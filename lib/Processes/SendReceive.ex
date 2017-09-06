defmodule Processes.SendReceive do
  @moduledoc """
  When a message is sent to a process, the message is stored in the process mailbox.
  The process that sends the message does not block on send/2. It puts the message in
  the receipent's mailbox and continues.
  """

  @doc """
  
      ## Examples
      iex> Processes.SendReceive.sendToSelf()
      {:hello, "world"}
  """
  def sendToSelf() do
    send self(), {:hello, "world"}
  end

  # IO.puts "• the receive block goes through the current process mailbox searching for a message"
  # IO.puts "  that matches any of the given patterns."
  # IO.puts "• receive supports guards and many clauses, such as case/2"
  # IO.puts "• if there is no message in the mailbox matching any of the patterns, the current"
  # IO.puts "  process will wait until a matching message arrives."

  # receive do
  #   {:hello, msg} -> IO.puts "Message Received: #{msg}"
  #   {:world, msg} -> IO.puts "Won't match: #{msg}"
  # end

# after
#   1_000 -> IO.puts "Nothing after 1 second"


# IO.puts "• a timeout of 0 can be given when you already expect the message to be in the mailbox."

end
