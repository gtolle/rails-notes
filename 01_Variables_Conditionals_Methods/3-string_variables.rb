puts "Now we're playing with strings"

# you can also put strings into variables, as we saw before with 'gets'

x = "two"
puts x

y = "three"
puts y

# you can add strings, as we saw
z = x + y

# z holds "twothree"

puts z

# look up what's in z ("twothree"), add "one" to it, and put that back into z.

z = z + "one"

# z holds "twothreeone"

puts z

# you can also convert a string to a number.
puts "3".to_i

# this doesn't work! ruby doesn't understand english. 
puts "three".to_i

# before you can add a number and a string, you need to convert the string into a number

a = 3
b = "3"
c = a + b.to_i

# what gets printed?

puts c
