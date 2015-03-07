# String Interpolation is awesome

# Let's set up a few variables first. numbers, strings, and strings that come from the user.

age = 33
height = 5 * 12 + 10
title = "the amazing"

puts "What's your name?"
name = gets.strip

# Before, you were doing it like this:

puts "My name is " + name + " and I'm " + age.to_s + " years old, and " + height.to_s + " inches tall"

# You have to convert your numbers into strings, include a lot of pluses, etc.

# It's not fun.

# Instead, use string interpolation. Any time you're in a string
# (between quotes), everything in between the #{...here...} is
# interpreted as ruby code. this could mean variable lookups, or even
# math, though you typically just do variable lookups. then the value
# in the variable is automatically converted into a string (no more
# .to_s!) and then inserted into the string in place.

puts "My name is #{name} and I'm #{age} years old, and #{height} inches tall"

puts
puts

# You can use it to format strings with variables, and you're going to 
# be doing this kind of stuff all the time when you build webapps

puts "My dog is #{age / 3} years old"
