# You could keep writing the same code (22*4) over and over again.

puts 22*44
puts 22*44
puts 22*44
puts 22*44
puts 22*44

# But let's say you only wanted to write it once. You could write it
# in a method, then give that method a name. 

def multiply
  puts 22*44
end

# Then you can call the method as many times as you want.

multiply
multiply
multiply
multiply
multiply
multiply

# But, that method is kind of boring. It does the same thing every
# time. 

# You can write a method that does different things depending on its
# "parameters". Now this is the cool part. You can call the parameters
# anything you want. We might call them 'x' and 'y', but let's call
# them 'cat' and 'dog' for fun. NOTE: don't name all your variables
# 'cat' and 'dog'. :)

# The parameters are only meaningful _inside_ the method, but beyond
# that, they're just like regular variables.

def multiply_with_params(cat, dog)
  puts cat * dog
end

multiply_with_params( 10, 12 )
multiply_with_params(2,2)
multiply_with_params(4,5)

# Here's the other cool part. Remember how '.to_s' would take an
# integer and return a string? Your methods can "return" things too.

# FYI, the next call won't work because your multiply_with_params
# method doesn't have a 'return' statement

age = multiply_with_params( 10, 12 )
puts "My age is #{age}"

# Let's make one that does.

def multiply_with_params_and_return(cat, dog)
  cat = cat * 2
  puts "another thing"
  return cat * dog
end

# Now we're talking. Your method can do lots of things, and then
# return a single value at the end. This value can be an integer, a
# string, or something more complex like an array or hash.

age = multiply_with_params_and_return( 10, 12 )
puts "My age is #{age}"

# Also, if you place the return statement earlier, the method will
# return earlier.

def multiply_with_params_and_return(cat, dog)
  return cat * dog 
  cat = cat * 2  # this line won't run
  puts "another thing" # this line won't run
end

# Another thing about Ruby is that the last line of the method
# automatically becomes the return. You should know this because lots
# of code uses it. But, I recommend explicit return statements
# wherever possible, unless you really know what you're doing.

def multiply_with_params_and_implicit_return(cat, dog)
  puts "hello"
  4 * 5
  cat * dog
end

age = multiply_with_params_and_implicit_return( 10, 12 )
puts "My age is #{age}"
