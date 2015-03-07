# Ruby programs run from top to bottom.
# We're going to start by learning how to interact with a user through the terminal.

# puts "string" prints "string" to the terminal

puts "Hello, everybody!"
puts "What is your name?"

# gets waits for the user to type something and hit enter

# the equals sign (or 'assignment operator') creates a variable with
# the name on the left side and saves the thing on the right side into
# that variable

# a variable is like a cubbyhole with a name. you can't see it, but
# you have to imagine that it's out there all the time. your program
# starts with no cubbyholes, and they get created by assignment statements

# this line defines a cubbyhole (variable) called 'user_name', asks
# the user for text, and saves the text into that variable.

# if the user types "Gil", then the 'user_name' cubbyhole will hold "Gil"

user_name = gets

# puts can print more than just strings. it prints whatever's on the
# right side of it.  this line looks at what's in the 'user_name'
# variable (cubbyhole), let's say it's the string "Gil", and prints it out

puts user_name

# this line prints "Gil" again. looking into a variable cubbyhole doesn't remove what's in it.
puts user_name

# you can put anything you want into a variable. this puts the number
# 30 into the 'age' variable.

age = 30

# and this prints it out again

puts age

# this looks up what's in 'age' (30), adds 1 to it, and sticks the result back into 'age'

age = age + 1

# this looks into age (now holding 31) and prints it out

puts age

# this creates another variable called 'weight' and saves 180 into it

weight = 180

# this creates another variable called 'combo', looks up what's in
# 'age' (31, remember) and 'weight' (180), adds them, and puts the
# result into 'combo' (211)

combo = age + weight

# this prints out what's in combo (211)

puts combo

# you can also add strings. they get stuck back-to-back (concatenated)

output = "My weight is: " + "180"

# this prints "My weight is: 180"

puts output

# but you can't add a string and a number
# THIS WON'T WORK: puts "My age is: " + age

# instead, you have to convert the number into a string. 
# 'age.to_s' looks at what's in 'age' (31), then calls the 'to_s' method on that number. 
# 'to_s' returns a string, which you can then add (concatenate) with the string

puts "My age is: " + age.to_s

