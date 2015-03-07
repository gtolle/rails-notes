# OK, let's say you wanted to do something multiple times, like this

puts "going..."
puts "going..."
puts "going..."
puts "gone."

puts "----------"

# There's a better way! Loops!

# In Ruby, numbers have a method called 'times'. The argument for
# 'times' is what's called a "block" in ruby. It's like a method
# because it holds lines of code, but it doesn't have a name, and
# instead of def/end it's defined by do/end

# The 'times' method does whatever's in the block the number of times
# that it's called on.

3.times do
	puts "going..."
end
puts "gone."

# It doesn't just have to be a regular number. Let's say the user is
# telling you how many times to do something. Put the number in a
# variable, and call 'times' on it!

age = 2
age.times do 
	puts "what"
end

puts "----"

# There's another kind of loop that's useful for counting
# one-by-one. Numbers have an 'upto' and a 'downto' method, which also
# take a numeric argument. The upto method counts from the number up
# to the argument, and the downto method counts from the number down
# to the argument.

# The block also takes an argument, called 'num' here, but you can
# call it anything you want. Each time the block gets called, 'num' is
# set to the number we've counted upto or downto so far.

1.upto(3) do |num|
	puts "this is try #{num}"
end

3.downto(1) do |num|
	puts "#{num}"
end
puts "liftoff"

# You should know enough to write a program that prints the whole
# 'bottles of beer' song. Give it a shot!

# Take a look at the verses, think about the grammar, etc. Try to make
# it as close to this example as possible.

puts "99 bottles of beer on the wall"
puts "99 bottles of beer"
puts "you take one down, pass it around"
puts "98 bottles of beer on the wall"

puts "98 bottles of beer on the wall"
puts "98 bottles of beer"
puts "you take one down, pass it around"
puts "97 bottles of beer on the wall"

puts "97 bottles of beer on the wall"
# ad nauseam

puts "No more bottles of beer on the wall!"

# On your own, you should look up 'while' loops, which are loops
# that will loop as long as a condition is true, instead of a fixed
# number of times. They can come in handy too.

# Example while loop here:

try = 0
while try < 3
  puts "try #{try+1}"
  try = try + 1
end
puts "done"

# Hint: don't forget to change the variable in the condition inside
# the loop. Otherwise, your loop will go forever, your program will
# hang. If this happens, hit control, then c, to kill your program.

# You should also look into the 'break' statement, which will end
# _any_ loop early.

try = 0
while try < 10
  puts "trying #{try}"
  if try % 5 == 0 && try != 0
    puts "found a multiple of 5. stopping."
    break
  end
  try = try + 1
end
puts "done"
