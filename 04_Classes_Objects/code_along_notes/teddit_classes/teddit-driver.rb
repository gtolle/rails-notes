# Classes are great for organizing code.

# Instead of writing our app at the top level, let's try putting our
# app into its own Teddit class.

# Our code does 2 key things: downloads the stories and builds an
# array, and prints the contents of that array.

# So, we'll define 2 methods: download_stories and print_front_page

# This 'driver' class will create a new Teddit object, then call each
# of our two methods.

# This is the class you'll actually run at the Ruby command line, like:

# ruby teddit-driver.rb

# The Teddit class will be in lib/teddit.rb, so we need to require it.
require_relative "lib/teddit"

# Now, let's make a new Teddit object, and then call our nice friendly
# methods to do the work.

teddit = Teddit.new
teddit.download_stories
teddit.print_front_page
