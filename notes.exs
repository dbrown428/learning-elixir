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
f = "Hello
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

# =============================================================================
# Binaries, strings, and char lists
# =============================================================================


