# let's try some more variable manipulations

puts "Welcome to BEWD"

# create a variable 'x', put 2 into it. easy

x = 2

# create a variable 'y', put 3 into it. also easy

y = 3

# create a variable 'z', look up what's in 'x' and 'y', add them, and put it into 'z' 

z = x + y
# z now holds 5

# you can re-assign a variable at any time. this is totally OK.
# look up what's in 'x' and 'y' (2 and 3), multiply them, and then stick the result into 'z'

z = x * y
# z now holds 6

# you can look up a variable, mess with it, and reassign it to itself
# this pulls out 'z' (6), adds 1 to that, then puts the result back into 'z'

z = z + 1
# z now holds 7

# you can do this over and over again

z = z + 1
# z now holds 8

z = z + 1
# z now holds 9

# you can also reassign a variable you used a long time ago. even
# though 'x' will be 81 from here on forward, it doesn't change the
# fact that 'x' was 2 when the program started.

x = z * z
# x now holds 81

# what do z and x hold?

puts "The answer is: " + z.to_s
puts "X is: " + x.to_s


