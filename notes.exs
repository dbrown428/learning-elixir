IO.puts "Playground"

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
