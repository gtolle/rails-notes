# We're going to take our basic Teddit app and change it to use a
# Story class instead of a simple hash when we save stories

# First, our usual 'requires'

require "rest-client"
require "json"
require "pp"

# We start by defining a Story class. 

# Why use classes?

# 1. Structured data storage.

# The Story class defines what a Story "is". In our codebase, a Story
# is an object that has 3 attributes: a title, a category, and a
# number of upvotes. And every Story is the same.

# If we were using hashes, we wouldn't be able to define it in
# advance. And if we mistype a key, then we won't realize it's a
# problem until we're running the app. With a class, if we name the
# attribute "category" and then try to get it or set it by "cakegory",
# we'll get an error the first time we try.

# 2. Combining methods with data, and organizing methods.

# We'll get into this later.

# In Ruby, the best practice is to define each class in its own
# file. The name of the class should be singular, because it
# represents an individual object. The name of the class should have a
# capital as its first letter, but the name of the file should be all
# in lowercase.

# We'll create our Story class inside a file called 'story.rb', and
# we'll put it in the 'lib' subdirectory.

# Go read that file now.

# Then come back here.

# To make Story usable in our program, we need to 'require_relative'
# the lib/story.rb file. 'require_relative' is like 'require', but
# looks for files relative to the path where the file containing the
# 'require_relative' statement is located.

require_relative "lib/story"

# Now, we're back to our usual Teddit app. Loading stories...

reddit_stories = JSON.load(RestClient.get("http://www.reddit.com/hot.json"))

stories = []

# Extracting the good bits...

reddit_stories["data"]["children"].each do |reddit_story|

  # But, we aren't using a hash anymore.

  #	new_story = { 
  #		:title => reddit_story["data"]["title"], 
  #		:category => reddit_story["data"]["subreddit"], 
  #		:upvotes => reddit_story["data"]["score"] 
  #	}

  # Instead, we're making a new instance of the Story class.
  # At this point, all the attributes are still empty.

  new_story = Story.new                             # kinda like new_story = {}
  
  # Then, we fill up each of the attributes.

  new_story.title = reddit_story["data"]["title"]   # kinda like new_story[:title] = reddit_story["data"]["title"]
  new_story.category = reddit_story["data"]["subreddit"]
  new_story.upvotes = reddit_story["data"]["score"]

  # In class, I asked everyone to add a 4th attribute: :author

  new_story.author = reddit_story["data"]["author"]

  # Then, we can push each instance into the 'stories' array, just
  # like we were doing with hashes. Instead of an array of hashes,
  # 'stories' is now an array of Story objects.

  stories.push( new_story )
end

# Now we print the front page.

puts "Teddit Front Page"
stories.each do |story|

  # Each 'story' isn't a hash anymore, so we can't use hash-key access (e.g. story[:upvotes])

  #	puts "#{story[:upvotes]} #{story[:title]} (#{story[:category]})"

  # Instead, we call the 'upvotes' method, which is how we access the
  # :upvotes attribute.

  # Also, note the call to 'modified_upvotes'. That's a method we
  # defined in Story. Instead of just returning the upvotes, it does a
  # check on the title of that story, and returns a modified number of
  # upvotes if the title contains certain words.

  puts "#{story.upvotes} #{story.title} (#{story.category}) by #{story.author}, the modified upvotes are = #{story.modified_upvotes}"
end

# And we're done!

