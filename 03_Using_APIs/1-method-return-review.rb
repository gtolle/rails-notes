# There were some questions about when to use 'puts' and when to use 'return'

# Let's review methods a bit and discuss that.

# First, we're doing to write some code:

puts "Hi there!"

# A method lets you give a name to a block of code. This method is
# called 'welcome_everybody', and it prints 3 lines.

def welcome_everybody
	puts "Hi there!"
	puts "You rock"
	puts "This is great"
end

# Once you've named your block of code, you can run it by 'calling'
# the method. When the program gets to the next line, it jumps to the
# beginning of the 'welcome_everybody' method and puts "Hi
# there!". Then, it puts the other 2 lines. Then it comes back to
# where we started, and keeps running the code below it.

welcome_everybody()

# Now let's write a bit more code that prints out a math result.

puts 22*44

# now, let's put that piece of code into a method instead

def multiply
  puts 22 * 44
end

multiply

# This does what you'd expect. But remember the 'length' method on a
# string? It _returns_ the length of the string, so we can save it
# into a variable.

def multiply(x, y)
  return x * y
end

answer = multiply(3, 5)

puts "The answer is #{answer}"

