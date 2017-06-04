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
IO.puts "n1 = #{n1}\nn2 = #{n2}\nn3 = #{n3}"

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

IO.puts "\nConvert to string…"
IO.puts "• polymorphic (char lists, integers, atoms, etc."
IO.puts "• Convert 'hełło' to a string using to_string:"
o3 = to_string(o1)
IO.puts "    Is list? #{is_list o3}"

IO.puts "\n\n============================================================================="
IO.puts "Keywords and maps"
IO.puts "============================================================================="

