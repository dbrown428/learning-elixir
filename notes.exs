IO.puts "Playground"

# =============================================================================
# Basic Types
# =============================================================================

x = 4
IO.puts "x: #{x}"

# Returns an integer.
y = div x, 3
IO.puts "y: #{y}"

# Returns a float.
z = x / 3
IO.puts "z: #{z}"

# Return the remainder
a = rem x, 3
IO.puts "a: #{a}"

# Rounding
b = round 3.58
IO.puts "b: #{b}"

# Booleans
c = true
d = 1
cd = c == d
IO.puts "cd: #{cd}"

# Atoms
e = :hello
IO.puts "e: #{e}"
IO.puts "is atom? #{is_atom(e)}"
IO.puts "is boolean? #{is_boolean(e)}"

# Strings
f = "hełło
worldﬁ!"
IO.puts f
IO.puts "String length: #{String.length(f)}"
IO.puts "Is Binary? #{is_binary(f)}"
IO.puts "bytes: #{byte_size(f)}"
IO.puts "uppercase:  #{String.upcase(f)}"

# Anonymous Functions
g = fn arg1, arg2 -> "#{arg1} #{arg2}" end

# the (.) is required to invoke an anonymous function.
IO.puts g.("hello", 43)
IO.puts "is function? #{is_function(g)}"

# Arity of the function
IO.puts "expects 1 argument? #{is_function(g, 1)}"
IO.puts "expects 2 argument? #{is_function(g, 2)}"

# Functions using functions
cool = fn a -> g.(a, a) end
IO.puts cool.(2)

# Linked Lists
h = ["1", "2", "3"]
IO.puts "Linked list: #{h}"
g = ["4", "5", "6"]
IO.puts "Concatenate: #{h ++ g}"
i = ["1", "2"]
IO.puts "Subtract: #{h -- i}"
IO.puts "head: #{hd(g)}"
IO.puts "tail: #{tl(g)}"
i2 = [104, 101, 108, 108, 111]
IO.puts "list of ASCII numbers: #{i2}"

# prepend items to a list with |
# list = [1,2,3]
# [0 | list]

# Accessing the length of a list is a linear operation: we need to traverse the whole list in order to figure out its size. Updating a list is fast as long as we are prepending elements. Calculating the length gets slower as the input grows.
i3 = [104 | i2]
IO.puts i3
IO.puts "linear operation - length: #{length i3}"

# Quotes
j1 = 'hello'
j2 = "hello"
IO.puts "equivalent? #{j1 == j2}"

# Tuples
# Getting a tuple size or accessing an element by index is fast, as tuples are stored contiguously in memory.
k = {:world, "hello"}
IO.puts tuple_size k
l = put_elem(k, 1, "great")
IO.puts "equal tuples? #{k == l}"
IO.puts "tuple element: #{elem(l, 0)}"

# Simple Rule: the function is named 'size' if the operation is in constant time (ie. the value is pre-calculated) or 'length' if the operation is linear.
# byte_size, tuple_size ~ constant time
# length, String.length ~ linear time

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
n8 = 34
{n9, n8} = {2, 34}
IO.puts "match variable value: #{n9}"

# underscore
[h | _] = [1, 2, 3]
IO.puts h

# =============================================================================
# Control Structures
# =============================================================================

# Case - is useful when you need to match against different values.
# ^ operation allows you to pattern match against an existing variable.
case {1, 2, 3} do
    {4, 5, 6} -> IO.puts "No match"
    {1, ^n8, 3} -> IO.puts "no match"
    {1, o, 3} -> IO.puts "Matched pattern: #{o}"
    _ -> IO.puts "match any value"
end

# Case guards
case {1, 0, 3} do
    {1, o1, 3} when o1 > 0 -> IO.puts "No match"
    _ -> IO.puts "Default match"
end

# Errors in guards do not leak, but make the guard fail
case 1 do
    x when hd(x) -> IO.puts "Won't match'"
    x -> IO.puts "Got #{x}"
end

# The number of arguments in each anonymous function clause needs to be the same.
f = fn
    x, y when x > 0 -> x + y
    x, y -> x * y
    # x, y, z -> x * y + z ... will not work.
end
IO.puts "Anonymous fn with clauses and guards: #{f.(1, 3)}"

# Cond - useful when you want to check different conditions and find the first
#        one that evaluates to true. Equivalent to else-if in many imperative languages.
cond do
    2 + 2 == 5 -> "This will not be true"
    2 * 2 == 3 -> "This will also not be true"
    1 + 1 == 2 -> IO.puts "cond true"
end

# Cond considers any value besides nil and false to be true.
cond do
    hd([1,2,3]) -> IO.puts "1 is considered as true"
end

# if and unless are useful when you need to check for only one condition
if true do
    IO.puts "if true"
end

unless false do
    IO.puts "unless false"
end

# false or nil
if nil do
    "this won't be seen"
else
    IO.puts "not nil"
end

# do/end blocks
# this syntax is using 'keyword lists'.
if true, do: IO.puts "do/end with comma separator"
if false, do: IO.puts "do/end", else: IO.puts "keyword list with else"

# the next two do/end blocks are equivalent:
if true do 
    a = 1 + 2
    a + 10
end

if true, do: (
    a = 1 + 2
    a + 10
)

# do/end blocks are always bound to the outermost function call. Explicit
# parantheses can change the block binding.
IO.puts is_number(if true do 
    1 + 2
end)


IO.puts "\n\n============================================================================="
IO.puts "Binaries, strings, and char lists"
IO.puts "============================================================================="

IO.puts "\nUTF-8 and Unicode"
IO.puts "=================================================================="
IO.puts "• a string is a UTF-8 encoded binary."
IO.puts "• Unicode is a standard (https://unicode-table.com/en/) that assigns code points to characters we know."
IO.puts "• when representing code points in bytes they need to be encoded somehow., eg. UTF-8"
IO.puts "• default encoding for Elixir is UTF-8"

IO.puts "\nByte Size of UTF-8 encoded characters…"
IO.puts "• byte size of 'L' is #{byte_size("L")}"
IO.puts "• byte size of 'ł' is #{byte_size("ł")}"
IO.puts "• byte size of '😀' is #{byte_size("😀")}"

IO.puts "\nCompare string length and byte size of a UTF-8…"
m = "hełło"
IO.puts "• String length of 'hełło': #{String.length m}"
IO.puts "• Byte size of 'hełło': #{byte_size m}"

IO.puts "\nCodepoints…"
# Note the ? is operating on a character and not a variable.
IO.puts "• Code point for 'a': #{?a}"
IO.puts "• Split a string (#{m}) into individual characters using 'String.codepoints':"
Enum.map(String.codepoints(m), fn mm -> IO.puts "    #{mm}" end)

IO.puts "\nBinaries"
IO.puts "=================================================================="
IO.puts "• a binary is a sequence of bytes, and the bytes can be organized in any way."
IO.puts "• a binary is a bitstring where the number of bits is divisible by 8"
IO.puts "• define a binary using <<>>"
IO.puts "• example: <<0, 1, 2, 3>>"
IO.puts "• byte size of <<0, 1, 2, 3>>: #{byte_size <<0, 1, 2, 3>>}"

IO.puts "\nRemember a string (binary) is a sequence of bytes…"
IO.puts "• is this binary '<<239, 191, 191>>' a valid string? #{String.valid? <<239, 191, 191>>}"
IO.puts "• is this binary '<<104, 101, 197, 130, 197, 130, 111>>' a valid string? #{String.valid? <<104, 101, 197, 130, 197, 130, 111>>}"
IO.puts "• this binary <<104, 101, 197, 130, 197, 130, 111>> as a string: #{<<104, 101, 197, 130, 197, 130, 111>>}"

IO.puts "\nBinary Concatentation"
IO.puts "• concatenate two binaries using the <> operator"
IO.puts "• example: <<0, 1>> <> <<2, 3>> = <<0, 1, 2, 3>>"
IO.puts "• is '<<0, 1>> <> <<2, 3>>' equal to <<0, 1, 2, 3>>? #{<<0, 1>> <> <<2, 3>> == <<0, 1, 2, 3>>}"

IO.puts "\nTIP: Concatenate the null byte to see the inner binary representation…"
m0 = "hełło" <> <<0>>
mm0 = to_charlist(m0)
IO.puts "Inner binary representation of '\"hełło\" <> <<0>>':"
Enum.map(mm0, fn mm -> IO.puts "    #{mm}" end)
IO.puts inspect mm0

IO.puts "\nBinaries allow modifiers to be given to store numbers bigger than 255…"
IO.puts "• 104 is a valid number (0 to 255) to represent a byte: #{<<104>>}"
IO.puts "• 256 is invalid and will be truncated to <<0>> also known as the null byte#{<<256>>}"
IO.puts "• 256 can be stored using 16 bits: <<256 :: size(16)>>: <<1, 0>>"
IO.puts "• 256 can be stored using UTF8: <<256 :: utf8>>: #{<<256 :: utf8>>}"
IO.puts "• use the null byte (<<0>>) to see the inner binary represenation: <<256 :: utf8, 0>>: <<196, 128, 0>>"

IO.puts "\nBitstring"
IO.puts "• a bunch of bits"
IO.puts "• is '<<1 :: size(1)>>' a bitstring? #{is_bitstring(<<1 :: size(1)>>)}"
IO.puts "• is '<<1 :: size(1)>>' a binary? #{is_binary(<<1 :: size(1)>>)}"
IO.puts "• is '<<1 :: size(8)>>' a bitstring? #{is_bitstring(<<1 :: size(8)>>)}"
IO.puts "• is '<<1 :: size(8)>>' a binary? #{is_binary(<<1 :: size(8)>>)}"

IO.puts "\nPattern match on binaries / bitstrings…"
IO.puts "• Match a known size <<104, 101, x>> = <<104, 101, 111>>: "
case <<104, 101, 111>> do
    <<104, 101, m3>> -> IO.puts "    x = #{m3}\n    Is x binary? #{is_binary m3}\n    Is x bitstring? #{is_bitstring m3}"
    _ -> IO.puts "match any value"
end

IO.puts "• Match an unknown size <<104, 101, x :: binary>> = <<104, 101, 197, 130, 197, 130, 111>>: "
case <<104, 101, 197, 130, 197, 130, 111>> do
    <<104, 101, m5 :: binary>> -> IO.puts "    x = #{m5}\n    Is x binary? #{is_binary m5}\n    Is x bitstring? #{is_bitstring m5}\n    Byte Size of x: #{byte_size(m5)}"
    _ -> IO.puts "match any value"
end

IO.puts "• achieve similar results with the string concatenation <> operator:"
"he" <> m4 = "hełło"
IO.puts "    \"he\" <> rest = \"hełło\": #{m4}"

IO.puts "\nChar lists"
IO.puts "=================================================================="
IO.puts "• a list of code points."
IO.puts "• used mostly when interfacing with Erlang."
IO.puts "• create with single-quated literals: 'hełło'"
o1 = 'hełło'
o2 = "hełło"
IO.puts "    Is 'hełło' a list? #{is_list o1}"
IO.puts "    Is \"hełło\" a list? #{is_list o2}"
IO.puts "    Code points for 'hełło' char list:"
Enum.map(o1, fn o3 -> IO.puts "        #{o3}" end)
IO.puts "        #{inspect o1}"

IO.puts "\nConvert to string…"
IO.puts "• polymorphic (char lists, integers, atoms, etc."
IO.puts "• Convert 'hełło' to a string using to_string:"
o3 = to_string(o1)
IO.puts "    Is list? #{is_list o3}"

IO.puts "\n\n============================================================================="
IO.puts "Keywords and maps"
IO.puts "============================================================================="
IO.puts "• associative data structures"

IO.puts "\nKeyword Lists"
IO.puts "=================================================================="
IO.puts "• keyword lists are the default mechanism for passing options to functions"
IO.puts "• provide same linear performance characteristics as lists, eg. the longer "
IO.puts "  the list, the longer it will take to find a key, count the number of "
IO.puts "  items... etc."
IO.puts "• use a tuple to represent the key-value data structure"
IO.puts "• the first item of the tuple (key) is an atom. The key must be an atom."
IO.puts "• keys are ordered as specified by the developer."
IO.puts "• keys can be given more than once."
IO.puts "• {:key, value}"
IO.puts "• example: [{:a, 1}, {:b, 2}]"

p0 = [{:a, 1}, {:b, 2}]
IO.puts "    What is the value of :a? #{p0[:a]}"
IO.puts "    What is the value of :b? #{p0[:b]}"

IO.puts "• there is also a special syntax for defining keyword lists: [key: value]"
IO.puts "• example: [a: 1, b: 2]"
p1 = [a: 1, b: 2]
IO.puts "    [a: 1, b: 2] == [{:a, 1}, {:b, 2}]? #{p0 == p1}"

p2 = [a: 0, a: 1, b: 2]
IO.puts "• define the key more than once: [a: 0, a: 1, b: 2], what is :a? #{p2[:a]}"

IO.puts "\nList operations…"
IO.puts "• all operations available to lists can be used on keyword lists"
p3 = [a: 1, b: 2] ++ [c: 3] == [a: 1, b: 2, c: 3]
IO.puts "• addition (append): [a: 1, b: 2] ++ [c: 3] == [a: 1, b: 2, c: 3]? #{p3}"
p4 = [c: 3] ++ [a: 1, b: 2] == [c: 3, a: 1, b: 2]
IO.puts "• addition: (prepend): [c: 3] ++ [a: 1, b: 2] == [c: 3, a: 1, b: 2]? #{p4}"
p5 = [a: 1, b: 2, c: 3] -- [b: 2] == [a: 1, c: 3]
IO.puts "• subtraction: [a: 1, b: 2, c: 3] -- [b: 2] == [a: 1, c: 3]? #{}"

IO.puts "\nIf macro…"
IO.puts "• :do and :else are keyword lists."
IO.puts "• in general when the keyword list is the last argument of a function, "
IO.puts "  the square brackets are optional."
IO.puts "• the following are equivalent statements:"
IO.puts "    if false, do: :this, else: :that"
IO.puts "    if (false, [do: :this, else: :that])"
IO.puts "    if (false, [{:do, :this}, {:else, :that}]"

IO.puts "\nPattern Matching…"
IO.puts "• rarely done on keyword lists"
IO.puts "• requires the number of items and their order to match"
[a: p6] = [a: 1]
IO.puts "• [a: a] = [a: 1], a = #{p6}"

IO.puts "\nMaps"
IO.puts "=================================================================="
IO.puts "• the go to data structure"
IO.puts "• allow any value as a key."
IO.puts "• do not follow any ordering."
IO.puts "• very helpful with pattern matching."
IO.puts "• created using the %{} syntax:"
q1 = %{:a => 1, 2 => :b}
IO.puts "    %{:a => 1, 2 => :b}"
IO.puts "    What is the value of :a? #{q1[:a]}"
IO.puts "    What is the value of 2? #{q1[2]}"
IO.puts "    What is the value of :c? #{q1[:c]} nil"

IO.puts "\nPattern Matching…"
IO.puts "• will always match on a subset of the given value:"
IO.puts "    %{:a => a} = %{:a => 1, 2 => :b}"
case %{:a => 1, 2 => :b} do
    %{:a => a} -> IO.puts "        a = #{a}"
    _ -> IO.puts "        No match found."
end

IO.puts "    %{:c => c} = %{:a => 1, 2 => :b}"
case %{:a => 1, 2 => :b} do
    %{:c => c} -> IO.puts "        c = #{c}"
    _ -> IO.puts "        No match found."
end

IO.puts "• an empty map matches all maps:"
IO.puts "    %{} = %{:a => 1, 2 => :b}"
case %{:a => 1, 2 => :b} do
    %{} -> IO.puts "        match all maps"
end

IO.puts "• variables can be used when accessing, matching and adding key maps."
q2 = 1
q3 = %{q2 => :one}
IO.puts "    q2 = 1"
IO.puts "    q3 = %{q2 => :one}"
IO.puts "    q3[q2]? #{q3[q2]}"
IO.puts "• remember the ^ operator allows you to match against an existing variable"
IO.puts "    %{^q2 => one} = %{1 => :one, 2 => :two, 3 => :three}"
case %{1 => :one, 2 => :two, 3 => :three} do
    %{^q2 => one} -> IO.puts "        Match!"
end

IO.puts "\nManipulate Maps…"
q4 = %{:a => 1, 2 => :b}
q5 = Map.get(q4, :a)
IO.puts "• Map.get(%{:a => 1, 2 => :b}, :a) = #{q5}"
IO.puts "• Map.put(%{:a => 1, 2 => :b}, :c, 3) == %{2 => :b, :a => 1, :c => 3}? #{Map.put(q4, :c, 3) == %{2 => :b, :a => 1, :c => 3}}"
IO.puts "• Map.to_list(%{:a => 1, 2 => :b}) == [{2, :b}, {:a, 1}]? #{Map.to_list(q4) == [{2, :b}, {:a, 1}]}"
IO.puts "• update a key's value (key must exist):"
q6 = %{q4 | 2 => "two"}
IO.puts "    %{%{:a => 1, 2 => :b} | 2 => \"two\"} == %{:a => 1, 2 => :b}? #{q4 == q6}"
IO.puts "• the | cannot be used to add new keys"

IO.puts "\nAccessing atom keys…"
IO.puts "• %{:a => 1, 2 => :b}.a = #{%{:a => 1, 2 => :b}.a}"
IO.puts "• use the map.field syntax and pattern matching instead of functions in the Map module."

IO.puts "\nNested Data Structures"
IO.puts "=================================================================="
IO.puts "• conveniences for manipulaing nested data structures, such as:"
IO.puts "    put_in"
IO.puts "    update_in"
IO.puts "    get_and_update_in"
IO.puts "• maintains the immutable properties of the language."

q7 = [
    john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
    mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

IO.puts "    What is John's age? #{q7[:john].age}"
IO.puts "    How many languages does Mary know? #{length q7[:mary].languages}"
IO.puts "    How many user's are there? #{length q7}"

# these statements mutate the data…
q7 = put_in q7[:john].age, 31
IO.puts "•  John's age after update? #{q7[:john].age}"
q7 = update_in q7[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
IO.puts "• How many languages does Mary know after update? #{length q7[:mary].languages}"

IO.puts "\n\n============================================================================="
IO.puts "Modules and Functions"
IO.puts "============================================================================="
IO.puts "• groups several functions into modules."
IO.puts "• create a module using the 'defmodule' macro, and 'def' to define functions."
IO.puts "• it's convenient to write modules into files so they can be compiled and reused."

IO.puts """
defmodule Math do
    def sum(a, b) do
        a + b
    end
end
"""

require Math
IO.puts "    Math.sum(1, 2) = #{Math.sum(1, 2)}"

IO.puts "• projects are usually organized into three directories:"
IO.puts "    ebin - contains the compiled bytecode"
IO.puts "    lib - contains elixir code (usually .ex files)"
IO.puts "    test - contains tests (usually .exs files)"
IO.puts "• mix will be responsible for compiling and setting up proper paths"

IO.puts "\nScripted Mode…"
IO.puts "• .exs files are for scripting"
IO.puts "• .ex files are meant to be compiled"
IO.puts "• when executed, both extensions compile and load their modules into memory"
IO.puts "• .ex files write bytecode to disk in the format of .beam files"

IO.puts "\nNamed functions…"
IO.puts "• private functions are defined with 'defp'"
IO.puts """
defmodule LoveLife do
    def sum(a, b) do
        do_sum(a, b)
    end

    defp do_sum(a, b) do
        a + b
    end
end
"""

require LoveLife
IO.puts "    LoveLife.sum(4, 5) = #{LoveLife.sum(4, 5)}"
IO.puts """
defmodule GuardsMultipleClauses do
    def zero?(0) do
        true
    end

    def zero?(x) when is_integer(x) do
        false
    end
end
"""

require GuardsMultipleClauses
IO.puts "    GuardsMultipleClauses.zero?(0)? #{GuardsMultipleClauses.zero?(0)}"
IO.puts "    GuardsMultipleClauses.zero?(2)? #{GuardsMultipleClauses.zero?(2)}"
IO.puts "• given an argument that does not match any of the clauses raises an error."
IO.puts "• named functions support both do: and do/end block syntax"
IO.puts """
defmodule DoBlock do
    def zero?(0), do: true
    def zero?(x) when is_float(x), do: false
end
"""


IO.puts "\nDefault Arguments…"
IO.puts "• named functions support default arguments: \\ \"value\""
IO.puts """
defmodule Concat do
    def join(a, b, sep \\ "-") do
        # remember <> is a string concatenator
        a <> sep <> b
    end
end
"""

require Concat
IO.puts "    #{Concat.join("Hello", "World")}"
IO.puts "    #{Concat.join("Hello", "World", "+")}"
IO.puts "• default values are only evaluated if they have to be used."
IO.puts "• be cautious of function definition order with default values."
IO.puts "• if a function has multiple clauses, it is required to create a"
IO.puts "  function head without an actual body."
IO.puts """
defmodule Words do
    def join(a, b \\ nil, sep \\ "_")

    def join(a, b, sep) when is_nil(b) do
        a
    end

    def join(a, b, sep) do
        a <> sep <> b
    end
end
"""

require Words
IO.puts "    #{Words.join("Hello", "World")}"
IO.puts "    #{Words.join("Hello", "World", "+")}"
IO.puts "    #{Words.join("Hello")}"

IO.puts "\n\n============================================================================="
IO.puts "Recursion"
IO.puts "============================================================================="

IO.puts """
defmodule Loop do
    def print_multiple_times(message, count) when count <= 1 do
        IO.puts message
    end

    def print_multiple_times(message, count) do
        IO.puts message
        print_multiple_times(message, count - 1)
    end
end
"""

require Loop
Loop.print_multiple_times("Hello!", 3)

IO.puts """
defmodule Reducing do
    def sum_list([head | tail], accumulator) do
        sum_list(tail, head + accumulator)
    end

    def sum_list([], accumulator) do
        accumulator
    end
end
"""

require Reducing
IO.puts Reducing.sum_list([1,2,3], 0)

IO.puts """
defmodule Mapping do
    def double_each([head | tail]) do
        #prepend the doubled head value to the list
        [head * 2 | double_each(tail)]
    end

    def double_each([]) do
        []
    end
end
"""

require Mapping
Mapping.double_each([1,2,3])

IO.puts "\n\n============================================================================="
IO.puts "Enumerables"
IO.puts "============================================================================="

IO.puts "• You rarely use recursion as above to manipulate lists. Use the Enum module."
IO.puts "• all the functions in the Enum module are eager, eg. expect an enumerable and "
IO.puts "  return a list back."
r0 = Enum.reduce([1,2,3], 0, fn(x, acc) -> x + acc end)
IO.puts "    Enum.reduce([1,2,3]… #{r0}"
r1 = Enum.map([1,2,3], fn(x) -> x * 2 end)
IO.puts "    Enum.map([1,2,3], fn x -> x * 2 end"
Enum.map(r1, fn rr1 -> IO.puts rr1 end)

r2 = Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end)
IO.puts r2

IO.puts "\nRanges"
IO.puts "• Enum.map(1..3, fn x -> x * 2 end)"
Enum.map(1..3, fn rr3 -> IO.puts "    #{rr3 * 3}" end)

r4 = Enum.reduce(1..3, 0, fn(rr4, acc) -> rr4 + acc end)
IO.puts "• Enum.reduce(1..3, 0, fn (x, acc) -> x + acc end)"
IO.puts "    #{r4}"

# We are capturing the function in a value. Equivalent to: fn x -> rem(x, 2) != 0 end
r5_odd? = &(rem(&1, 2) != 0)
r5 = Enum.filter(1..3, r5_odd?)
IO.puts "• Enum.filter(1..3, fn x -> rem(x, 2) != 0 end)"
Enum.map(r5, fn x -> IO.puts "    #{x}" end)

IO.puts "\nPipe Operator"
IO.puts "• Takes output from the expression on the left side and passes it as the first"
IO.puts "  argument to the function on the right side."
r6? = &(&1 * 3)
r7 = 1..100_000 
    |> Enum.map(r6?)
    |> Enum.filter(r5_odd?)
    |> Enum.sum

IO.puts "    1..100_000"
IO.puts "        |> Enum.map(r6?)"
IO.puts "        |> Enum.filter(r5_odd?)"
IO.puts "        |> Enum.sum"
IO.puts "    = #{r7}"

IO.puts "\nStreams"
IO.puts "• streams are lazy, composable enumerables"
IO.puts "• streams build a series of computations that are invoked only when"
IO.puts "  we pass the underlying stream to the Enum module."
IO.puts "• streams are useful when working with large, possibly infinite, collections."

r8 = 1..100_100
    |> Stream.map(r6?)
    |> Stream.filter(r5_odd?)
    |> Enum.sum

IO.puts "    1..100_100"
IO.puts "        |> Stream.map(&(&1 *3))"
IO.puts "        |> Stream.filter(r5_odd?)"
IO.puts "        |> Enum.sum"
IO.puts "    = #{r8}"

r9 = Stream.cycle([1,2,3])
rr9 = Enum.take(r9, 10)
IO.puts inspect rr9

IO.puts "• Stream.unfold(\"hełło\", &String.next_codepoint/1)"
r10 = Stream.unfold("hełło", &String.next_codepoint/1)
rr10 = Enum.take(r10, 3)
Enum.map(rr10, fn x -> IO.puts "    #{x}" end)

IO.puts "• Stream.resource/3"
# Enum.take(stream, 10)

IO.puts "\n\n============================================================================="
IO.puts "Processes"
IO.puts "============================================================================="

IO.puts "• all code runs inside processes"
IO.puts "• processes are isolated from each other, run concurrent to one another,"
IO.puts "  and communicate via message passing."
IO.puts "• extrememly lightweight in terms of memory and CPU"

IO.puts "\nspawn"
IO.puts "• takes a function and executes it in another process"
IO.puts "• returns a process identifier"

pid1 = spawn fn -> 1 + 2 end
IO.puts "Is process alive? #{Process.alive?(pid1)}"

pid2 = self()
IO.puts "Is process alive? #{Process.alive?(pid2)}"

IO.puts "\nSend and Receive"
IO.puts "• when a message is sent to a process, the message is stored in the process mailbox."
IO.puts "• the process that sends the message does not block on send/2. It puts the message in"
IO.puts "  the receipent's mailbox and continues."
IO.puts "\nsending message to self…\n"
send self(), {:hello, "world"}

IO.puts "• the receive block goes through the current process mailbox searching for a message"
IO.puts "  that matches any of the given patterns."
IO.puts "• receive supports guards and many clauses, such as case/2"
IO.puts "• if there is no message in the mailbox matching any of the patterns, the current"
IO.puts "  process will wait until a matching message arrives."

receive do
    {:hello, msg} -> IO.puts "\nMessage Received: #{msg}\n"
    {:world, msg} -> IO.puts "Won't match: #{msg}"
after
    1_000 -> IO.puts "Nothing after 1 second"
end

IO.puts "• a timeout of 0 can be given when you already expect the message to be in the mailbox."

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


