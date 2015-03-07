# besides numbers and strings, you can put "boolean" values into
# variables. booleans are either true or false.

# you get a boolean by doing a comparison

puts "Is 7 greater than 8?"

# look at the right side, see if 7 is greater than 8, store the result into 'result'
# it's false

result = 7 > 8
puts result

puts "Is 8 x 77 greater than 600?"

# you can do math inside of comparisons. first, we multiply 8 by
# 77 and get 616. then we compare that number to 600. it's greater? we store true into 'result'.

result = 8 * 77 > 600
puts result

puts "Is 1 equal to 7 - 6?"

# the ancient gods of programming decreed that "the equal sign is used for assignment"
# which means they stole it, and we can't use the equal sign for comparison
# instead, we have to use _two_ equals signs back to back

# subtract 6 from 7, then compare it to 1
# also, you don't have to store the boolean into a 'result' variable if you don't want to
# puts prints whatever's on the right side. in this case, it's going to print 'true'.

puts 1 == 7 - 6

puts "Is 77 greater than 50 AND is 88 / 3 less than 30?"

# you can set up a two-headed condition using the && (and) operator
# if both sides are true, then the overall condition is true
# if either side is false, the overall thing is false.
# "my name is Gil and his name is Alberto" is true
# "my name is Gil and his name is Fred" is false, even though my name _is_ Gil, his name isn't Fred
# "my name is James and his name is Fred" is obviously false

puts 77 > 50
puts 88 / 3 < 30
puts (77 > 50) && ((88 / 3) < 30)

# you can also combine conditions with the || (or) operator
# if either side is true, the whole thing is true

puts "Is 77 greater than 50 OR is 88 / 3 less than 30?"
puts (77 > 50) || ((88 / 3) < 30)

puts "Is the length of the word 'cat' more than 10 chars"

# remember .to_i? you do it to a string.
# you can do tons of things to strings.
# like ask how long it is, with .length'

username = "cat"
puts username
puts username.length

# username.length returns 3

puts username.length > 10

# then this comparison is false

puts "Does the word 'slaughter' include the word 'laughter'?"

# you can ask whether a string includes another string by calling the .include? method
# this method takes a parameter: the second string to look for
# if the first string contains the second, it's true
# someone else wrote this complicated string code and defined it as a method.
# you just get to call it. lucky you!

test_word = "slaughter"
result = test_word.include?("laughter")
puts result


