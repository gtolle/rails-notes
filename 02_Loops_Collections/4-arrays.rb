# Think of things you want to keep a list
# of. Friends. Tweets. Reviews.

# Anytime you want to make a list of things in Ruby, you use an
# array.  

# Think of an array as a row of numbered cubbyholes existing out there
# in variable space. Each of those cubbyholes can hold another thing,
# like a string or a number (or even another array or hash or anything
# else).

# See my drawing here.

# In Ruby, you define an array with square brackets. You write square
# bracket, _something_, comma, _something, comma, _something, etc,
# square bracket to close.

[ "Rakim", "Q-Tip", "Jay-Z", "Eminem" ]

# But, if you want to _do_ anything with the array, you need to assign
# it to a variable so you can access it. So far, we've seen variables
# holding numbers, strings, and booleans (true/false). Variables can
# also hold arrays.  (and hashes, and objects, which we'll see later).

rappers = [ "Rakim", "Q-Tip", "Jay-Z", "Eminem" ]

# Now, you can call methods on the array, access the items in the
# list, change the items in the list, etc. Here's how.

# Remember how Strings had a length method? Arrays do too. Google for
# 'ruby array docs' to see all the things you can do to an array.

puts "There are #{rappers.length} rappers"

# Of course, Array.length just returns a number, so you can save the
# result into another variable, and use it in some other part of your
# code.

num_rappers = rappers.length
puts "There are #{num_rappers} rappers"

# But let's say you want to print something based on the array. Arrays
# have an 'each' method. This method is awesome, and you'll use it
# _all the time_ in your web apps. It's kind of like 'times' back in
# loops. It takes a block, and that block has an argument. The each
# method will call the block once for each item in the array, and it
# will set the block argument equal to that item. 

# So you can do this.

rappers.each do |rapper|
	puts "Word up to #{rapper}"
end

# Arrays also have convenient 'first' and 'last' methods, which do
# what you'd expect - return the first item in the array or the last
# item.

puts "The oldest is #{rappers.first}"
puts "The newest is #{rappers.last}"

# But if you want to access a specific element of the array, you use
# square brackets and a number. Note that arrays count from zero. The
# first element is array[0], and the last element is array[length-1].

puts "In the middle...#{rappers[1]}"

puts "-----"

puts "A challenger appears!"

# We talked about accessing arrays. You can also change arrays. You'll
# do this a lot too. The 'push' method appends a new item to the end of the array.

rappers.push("Mr. Lif")

# Now, you'll see that the array from before has 5 items.

rappers.each do |rapper|
	puts "Word up to #{rapper}"
end

# There are other methods to put things at the beginning of arrays,
# and other methods to remove things from the end or beginning of
# arrays. Look them up in the ruby docs for arrays.

# Here's another super useful method for debugging. 'inspect' returns
# a string that contains all the items in the array, and formats the
# string with square brackets kind of like you defined it.

# You won't show a .inspect string to your users, but it'll be useful
# to see what's in the array when you're writing your own code.

puts "The array looks like this: #{rappers.inspect}"

# Remember String.include? that found substrings? Array has one too -
# it searches the array for an item. You can use this in if
# statements, or any other condition.

# This'll work.

if rappers.include?("Eminem")
  puts "It's slim shady"
end

# This won't.

if rappers.include?("Biggie")
  puts "Notorious"
end
