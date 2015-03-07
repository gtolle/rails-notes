# methods allow you to define a cubbyhole that holds _code_
# this cubbyhole has a name too, just like a variable

def welcome_to_class
  puts "Welcome to class"
end

# to run that code, you 'call' the method by name

welcome_to_class

# prints "Welcome to class"

# you can define lots of methods -- just define them before you call them

def ask_name
  puts "What is your name (in the method)?"
end

ask_name

# prints "What is your name (in the method)?"

name = gets

# methods can have 'arguments'. remember "slaughter".include?("laughter")
# then, you were using the include? method
# now you're defining your own!

# the 'name_to_check' variable gets filled in when the method starts
# it's only valid _inside_ the method

def is_the_instructor(name_to_check)
  if name_to_check.include?("Gil")
    puts "you're the instructor"
  end
end

# look up what's in the 'name' variable, then 'pass' it to the
# method. it fills in the 'name_to_check' variable inside the method

is_the_instructor(name)

# we can run the same piece of code again without writing it again!

ask_name
name = gets

# and again!

is_the_instructor(name)
