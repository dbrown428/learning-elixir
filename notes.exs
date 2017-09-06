IO.puts "Playground"

# =============================================================================
# Basic Operators
# =============================================================================

# String Concatenation
IO.puts 'concatenate: #{"foo" <> "bar"}'

# Boolean Operators - the first argument must be a boolean
# Use AND, OR, NOT when expecting booleans.
IO.puts "AND #{true and false}"
IO.puts "OR #{false or is_atom(:example)}"
IO.puts "NOT #{not false}"

# OR and AND are short-circuit operators. Only execute right-side if left-side is not enough to determine the result.
false and raise("This error will never be raised.")
true or raise("This error will never be raised.")

# These boolean operators accept all types.
# Use &&, ||, ! if any arguments are non-boolean.
IO.puts "1 || true? #{1 || true}"
IO.puts "false || 11? #{false || 11}"
IO.puts "nil && 13? #{nil && 13}"
IO.puts "true && 17? #{true && 17}"

# Equality Strictness
IO.puts "1 == 1.0? #{1 == 1.0}"
IO.puts "1 === 1.0? #{1 === 1.0}"

# Compare different data types
IO.puts "1 < :atom? #{1 < :atom}"

# =============================================================================
# Pattern Matching
# =============================================================================

# Match Operator
m = 31
IO.puts "31 = m? #{31 = m}"

# Pattern Matching on tuples
{n1, n2, n3} = {:happy, "day", 42}
IO.puts "n1 = #{n1}"
IO.puts "n2 = #{n2}"
IO.puts "n3 = #{n3}"

# Pattern Match on specific values
{:happy, n4} = {:happy, 13}
IO.puts "n4 = #{n4}"

# Pattern match on lists
[n5, n6, n7] = [1, 2, 3]
IO.puts "n5 = #{n5}\nn6 = #{n6}\nn7 = #{n7}"

# Matching head and tail
[head | tail] = [1, 2, 3]
IO.puts "head = #{head}"
IO.puts "tail = #{tail}"    # no value output... ??

# Pin Operator - match a variables value instead of rebinding
# ^ operation allows you to pattern match against an existing variable.
n8 = 34
{n9, n8} = {2, 34}
IO.puts "match variable value: #{n9}"

# underscore
[h | _] = [1, 2, 3]
IO.puts h


IO.puts "\n\n============================================================================="
IO.puts "Processes"
IO.puts "============================================================================="

IO.puts "\ninspect"
IO.puts "• used to convert a data structure's internal representation into a string."
r11 = [{:hello, "world"}, {:goodbye, "world"}]
IO.puts inspect r11

IO.puts "\nflush"
IO.puts "• used for debugging in the shell"
IO.puts "• flushes and prints all the messages in the mailbox"

IO.puts "\nLinks"
IO.puts "• links allow processes to establish a relationship in case of failures."
IO.puts "• processes are isolated and don't share anything by default."
IO.puts "• if we want failure in one process to propagate to another one, we should link them."
IO.puts "• if an error occurs in a spawned process it will be logged."
IO.puts "• linking processes will allow errors to propagate"
IO.puts "• we often link our processes to supervisors which will detect when a process dies and start a new process."
IO.puts "• processes and links play an important role when building fault-tolerant systems."

IO.puts "\nspawn fn -> raise \"oops\" end"
IO.puts "• this will crash the process, but the parent process will be unaffected."

IO.puts "\nspawn_link fn -> raise \"oops\" end"
IO.puts "• this will crash the process and the parent process, because the parent process can is not setup to handle this failure."

IO.puts "• linking can also be done manually using 'Process.link/1'"


IO.puts "\nTasks"
IO.puts "• tasks are built on top of spawn functions to provide better error reports and introspection."
q1 = Task.start fn -> IO.puts "hello world" end
IO.puts inspect q1

# task.async
# task.await

IO.puts "\nState"
IO.puts "• imagine a process that loops indefinitely and maintains state (if your application requires state (eg. configuration from file)"
IO.puts "• seldom will you implement this pattern as there are many other abstractions that can help, such as Agent."

IO.puts "Agent.start_link(fn)"
IO.puts "Agent.update(pid, fn)"
IO.puts "Agent.get(pid, fn)"
# KeyValueRegistry.start


IO.puts "\n\n============================================================================="
IO.puts "IO and the file system"
IO.puts "============================================================================="

IO.puts "\nIO Module"
IO.puts "• main mechanism for reading/writing to standard input/output, standard error,"
IO.puts "  files, and other IO devices"

q2 = IO.gets "Y or N?"
IO.puts q2

IO.puts "• change where the IO module reads from by passing an argument:"
IO.puts "   IO.puts :stderr, \"hello world\""
IO.puts :stderr, "hello world"

IO.puts "\nFile Module"
IO.puts "• files are opened in binary mode by default"
IO.puts "• a tuple is returned, that we can pattern match against."
IO.puts "• {:ok, file} where file is actually a process id."
{:ok, file} = File.open "hello", [:write]
IO.binwrite file, "world"
File.close file
IO.puts inspect File.read "hello"

IO.puts "• a file can also be opened with :utf8 encoding"
IO.puts "• many functions are named after their UNIX equivalents, such as: "
IO.puts "      File.rm/1"
IO.puts "      File.mkdir/1"
IO.puts "      File.cp_r/2"
IO.puts "      File.rm_rf/1"

IO.puts "• ! (trailing bang) variant will return the contents of the file instead of a tuple."
IO.puts File.read! "hello"
IO.puts inspect File.read "hello"

IO.puts "• the version without ! is preferred when you want to handle different outcomes using pattern matching"
case File.read("hello") do
    {:ok, content} -> IO.puts "    #{content}"
    {:error, reason} -> IO.puts "    handle error: #{reason}"
end

IO.puts "• if you expect the file to be there, the bang variation is more useful as it raises a meaningful error message."
IO.puts "• if you don't want to handle the error outcomes, prefer user File.read!/1"
IO.puts "      {:ok, content} = File.read(\"test\") -> if file \"test\" does not exist this is just a pattern match error."

case File.read("test") do
    {:ok, content} -> IO.puts "    #{content}"
    {:error, reason} -> IO.puts "    error reading file: #{reason}"
end

IO.puts "\nPath Module"
IO.puts "• the File module expect paths as arguments"
IO.puts "• use the Path module functions instead of directly manipulating strings"
IO.puts "• takes care of different operating systems transparently."
q3 = Path.join("foo", "bar")
IO.puts "    Path.join(\"foo\", \"bar\")"
IO.puts "        #{q3}"
q4 = Path.expand("~/hello")
IO.puts "    Path.expand(\"~/hello\")"
IO.puts "        #{q4}"

IO.puts "\nGroup Leaders"
IO.puts "• the file open returns a tuple with the process id (file), eg. {:ok, file} = File.open(\"hello\")"
IO.puts "• by modelling IO devices with processes this allows different nodes on the same network"
IO.puts "  to exchange file processes in order to read/write files between nodes."
IO.puts "• the group leader is a special process"

IO.puts "\n\n============================================================================="
IO.puts "Alias, require, and import"
IO.puts "============================================================================="

IO.puts "\nalias"
IO.puts "• allows you to setup aliases for any given module name, eg. I want to call Bar instead of Foo.Bar "
IO.puts "    alias Foo.Bar, as: Bar"
HelloWorld.doodle()
HelloWorld.Greetings.something()

alias HelloWorld.Greetings, as: HelloThere
HelloThere.something()

IO.puts "• you can omit the as: portion and the alias will automatically be the last part of the module name."
IO.puts "    alias Foo.Bar"
IO.puts "       ^^ is the same as alias Foo.Bar as: Bar"

alias HelloWorld.Greetings
Greetings.something()

IO.puts "• alias is lexically scoped, so you can set aliases inside specific functions"
IO.puts "• multi-alias can be achieve like so…"
IO.puts "   alias MyApp.{Foo, Bar, Baz}"

alias HelloWorld.{Greetings, Goodbyes}
Goodbyes.ciao()
Greetings.something()

IO.puts "\nrequire"
IO.puts "• in order to use macros in modules, you need to opt-in by requiring the module they are defined in."
IO.puts "• require is lexically scoped, so you can require inside specific functions"
require Integer
IO.puts "    Integer.is_odd(3), #{Integer.is_odd(3)}"

IO.puts "\nimport"
IO.puts "• used when you want to easily access functions or macros from other modules without using the fully qualified name."
IO.puts "• when you import a module, it automatically requires it."
IO.puts "• lexically scoped so you can import insider function definitions."
IO.puts "• Instead of doing List.duplicate :ok, 3…"
IO.puts "    import List, only: [duplicate: 2]"
IO.puts "    duplicate :ok, 3"
IO.puts "• Import options…"
IO.puts "    only: (No need to import all the functions)"
IO.puts "        :macros (only import macros) > import Integer, only: :macros"
IO.puts "        :functions (only import functions) > import Integer, only: :functions"
IO.puts "    except: (import everything except the following)"
import HelloWorld.Greetings, only: [something: 0]
something()

IO.puts "\nuse"
IO.puts "• bring external functionality into the current lexical scope"
IO.puts """
defmodule AssertionTest do
  use ExUnit.Case, async: true

  test "always pass" do
    assert true
  end
end
"""

IO.puts "\n\n============================================================================="
IO.puts "Module Attributes"
IO.puts "============================================================================="
IO.puts "• annotate the module with information to be used by the user or the VM"
IO.puts "• work as constants"
IO.puts "• work as temporary module storage to be used during compilation"

IO.puts "\nAs annotations"
IO.puts "    @vsn - explicity setting the version, otherwise version is set to MD5 checksum of the module"
IO.puts "    @moduledoc - provides documentation for the current module"
IO.puts "    @doc - provides documentation for the function or the macro"
IO.puts "    @behaviour - specifying OTP or user defined behaviour"
IO.puts "    @before_compile - provides a hook before the module is compiled"

IO.puts "\nAs constants"
IO.puts "• a constant starts with the @ character."
defmodule MyServer do
  @initial_state %{host: "127.0.0.1", port: 3456}
  IO.inspect @initial_state
end

IO.puts "• constants can be read inside functions"

# redo this chapter.

IO.puts "\n\n============================================================================="
IO.puts "Structs"
IO.puts "============================================================================="
IO.puts "• structs are extensions built on top of maps"
IO.puts "• compile-time checks and default values"
IO.puts "• structs take the name of the module they are defined in"

IO.puts "• if no default value is specified when defining the struct, the nil will be assumed."
defmodule User do
    @enforce_keys [:name, :age]
    defstruct [:name, :age, home: "Canada"] 
end

q4 = %User{age: 22, name: "Jane"}
IO.puts "    User.age = #{q4.age}"
IO.puts "    User.name = #{q4.name}"
IO.puts "    User.home = #{q4.home}"

IO.puts "• use the update syntax |"
q5 = %{q4 | name: "Meg"}
IO.puts "    #{inspect q5}"

IO.puts "• pattern matching"
%User{name: qq5} = q4
IO.puts "    %User{name: qq5} = q4"
IO.puts "    qq5 = #{qq5}"

IO.puts "• structs are bare maps underneath"
IO.puts "    is_map(q5)? #{is_map(q5)}"
IO.puts "    q5.__struct__? #{q5.__struct__}"

IO.puts "• structs are referred to bare maps, because they don't have the same protocols implemented."
IO.puts "  eg. enumeration, access"
IO.puts "• structs work great with functions from the Map module"
IO.puts inspect Map.keys(q5)
IO.puts inspect Map.values(q5)


IO.puts "\n\n============================================================================="
IO.puts "Protocols"
IO.puts "============================================================================="
IO.puts "• a mechanism to achieve polymorphism at the data/type level"
IO.puts "• write code that can be extended to work with new data types I don't know about yet."
IO.puts "• it's possible to implement protocols for all types:"
IO.puts "    Atom, BitString, Float, Function, Integer, List, Map, PID, Port, Reference, Tuple"

defprotocol Size do
    def size(data)
end

defimpl Size, for: BitString do
    def size(string), do: byte_size(string)
end

IO.puts Size.size("foog")

defimpl Size, for: Map do
    def size(map), do: map_size(map)
end

IO.puts Size.size(%{label: "some label"})

defimpl Size, for: Tuple do
    def size(tuple), do: tuple_size(tuple)
end

IO.puts Size.size({:ok, "hello"})

IO.puts "\nProtocols and structs"




# Behaviours vs Protocols
# https://www.djm.org.uk/posts/elixir-behaviours-vs-protocols-what-is-the-difference/


