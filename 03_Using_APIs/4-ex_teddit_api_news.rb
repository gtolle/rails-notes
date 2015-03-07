# Exercise:

# Now that we've used the Reddit JSON API to make Teddit show
# something cool...

# Create a new version of Teddit, except use a different JSON API from
# a different site.

# e.g.

# Tashable: http://mashable.com/stories.json
# Tigg: http://digg.com/api/news/popular.json

# Pull the JSON, parse it, and add each story to your stories array
# Then print your own front page!

# NOTE: Digg doesn't seem to have 'categories' in a straightforward way.
# You could use the 'kicker', or you could use the first 'tag', or
# you could combine all the tags into a single string. Your call.

# IF YOU FINISH EARLY: one of the benefits of putting everything into the
# 'stories' array with simple 3-part hashes is that we now have a common 
# format for ALL news stories. So, extend your program to pull from Digg
# AND Mashable, and print one unified front page with all the stories.

# This would be a good time to start modularizing your code a bit. e.g.

# def get_mashable_stories
#   ...
#   return stories
# end

# def get_digg_stories
#   ...
#   return stories
# end

# def print_front_page( stories )
#   ...
# end

# stories = get_mashable_stories() + get_digg_stories()
# print_front_page( stories )

# NOTE: this can be a bit of a head-scratcher. You're actually creating 
# _a brand new 'stories' array_ inside of each of those get_..._stories() methods
# and returning that new array to the caller. Then, the caller combines those arrays.

# IF YOU FINISH THAT: print your front page in sorted order according to
# the 'upvotes'. Look up Array.sort on the ruby docs.

# IF YOU FINISH THAT: embrace Digg's tags. When you're pulling stories
# from Digg, convert the list of tag hashes into a simple
# comma-separated string, and use it as the category. 

# Look up Array.join in the ruby docs for a simple way to combine an
# array of strings into a single string.

# Look up Array.map in the ruby docs for a super easy way to convert
# an array of stuff (like hashes with tags in them) into another
# array (like simple strings representing the tag name).

# Look up the alternative syntax for do/end to make your .map code
# shorter. Instead of 
# array.map do |element|
#  stuff
# end.join(", ")
# You can do array.map { |element| stuff }.join(", ")

# IF YOU FINISH THAT: try multiplying the 'upvotes' field according to whether
# the stories contain 'cats', 'food', etc, or any other funny text
# you want.

