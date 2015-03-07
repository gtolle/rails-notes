require "rest-client"
require "json"
require "pp"

# We'll start by writing out our goals for the project.

# 1. download the list of top stories from Reddit as JSON

# 2. walk through the downloaded Reddit stories array and copy the
# important parts of each one (title, category (which is 'subreddit'),
# upvotes) into our 'stories' array

# 3. walk through our stories array and print out the "front page of
# Reddit" in the terminal

# Let's get going.

# 1. download the list of top stories from Reddit as JSON

# Reddit provides a list of its hot stories through a REST API.  REST
# stands for Representational State Transfer, but that's not super
# important. 

# A REST API is just a web page, except it returns data in a format
# that machines can read instead of HTML that humans can read.

# So, you access a REST API through a URL. You can try accessing this
# URL in your browser first. Taking a look at the output, you can see
# that it has the titles of the articles buried in there, the
# subreddit, and everything else about the front page.

# This REST API (and many others) return data in the JSON format,
# which stands for Javascript Object Notation. JSON is a standard way
# to represent common objects like ... you guessed it, arrays and
# hashes ... as text. In JSON, an array of hashes that contain strings
# and numbers looks like:

# [ { "name" : "Gil", "age" : 33 }, { "name" : "John", "age" : 28 } ]

# The syntax is a little different than Ruby, but that's OK, because
# we'll be transforming this JSON document into Ruby arrays and hashes
# soon.

# To access a REST API in Ruby, you use the RestClient
# library. RestClient doesn't come with Ruby. Instead, RestClient was
# written by some friendly people out on the Internet, and they've
# provided it to you as a Ruby Gem. RubyGems is a big archive of all
# the available code packages for Ruby, and you can install any one
# you want. It's like an app store, but for Ruby code.

# To use RestClient in your program, you need to 
# 1. Learn about the gem at: 
#   - http://rubygems.org/gems/rest-client
#   - http://rubydoc.info/gems/rest-client/1.6.7/frames
# 2. Install the Gem by running this at your terminal:
#   - gem install rest-client
# 3. Add this line to the top of your program:
#   - require "rest-client"

# RestClient.get(<url>) returns the contents of the page as a string,
# just like in the browser.

reddit_stories_json = RestClient.get("http://www.reddit.com/hot.json")

# Reddit's REST API returns 25 stories by default, but you can limit
# the number of stories it returns by giving it the "limit" argument
# in the query string of the URL. The query string is "the stuff after
# the question mark".

# reddit_stories_json = RestClient.get("http://www.reddit.com/hot.json?limit=2")

# You can learn about all this stuff by reading Reddit's API docs
# here: http://www.reddit.com/dev/api

# Now, let's look at the string that comes back from RestClient.get() by
# 'puts'ing the string in your terminal. You might also just want
# to look at the text in your web browser, or add the JSONView
# extension to Chrome and look at it there.

# puts reddit_stories_json

# Now, we need to deal with this big string. For that, we use the JSON
# library. The JSON library turns a string of JSON into real Ruby
# arrays and hashes. JSON was also written by someone else, and to use
# it in your program, you have to add this line to the top of your
# program:

# require "json"

reddit_stories = JSON.load(reddit_stories_json)

# To see the Ruby objects that came back from that JSON.load() call,
# you can use "pp". "pp" stands for pretty-print, and it will print
# any Ruby object - all the fields, all the arrays, all the way down.

# pp reddit_stories

# You should see a hash with hashes inside it, and arrays inside
# that. Except, the keys are strings (e.g. "data") and not symbols with colons
# (e.g. :data). You'll just have to deal with this - the JSON library
# produces hashes with string keys, but when we make hashes ourselves
# in Ruby, we use symbol keys.

# You'll see something like this, except with a lot of other keys in
# the hashes. I'm just showing a few keys to show the main structure.

# { "data" => 
#    { "children" => [ 
#         { "data" => { "title" => "Hi!" } }, 
#         { "data" => { "title" => "Bye!" } }
#       ]
#    }
# }

# Reddit gives you a hash with a "data" key, which you access, then
# you get a hash with a "children" key, which you access. Then you get
# an array of hashes, each of which has a "data" key, which you
# access, and then you get a hash that contains keys for all the
# important data about the story, like "title".

# Why is it this way? Ask the Reddit API designers. Every JSON/REST
# API has a different format, and you'll be getting practice decoding
# and understanding them.

# Goal 1 complete!

# 2. walk through the downloaded Reddit stories array and copy the
# important parts of each one (title, category (which is 'subreddit'),
# upvotes) into our 'stories' array

stories = []

# You can dig through the nested hashes by chaining brackets one after another.

# This will walk through the "data" key and then the "children" key,
# giving you the array inside it.

# pp reddit_stories["data"]["children"]

# So, we have an array - we can call 'each' on it to walk through all the stories.

reddit_stories["data"]["children"].each do |reddit_story|
  # You can use 'pp' to inspect the story.

  # pp reddit_story

  # Now, we can pull out the values we care about from the
  # reddit_story, and put each one into a temporary variable.

  title = reddit_story["data"]["title"]
  category = reddit_story["data"]["subreddit"]
  upvotes = reddit_story["data"]["score"]

  # Then, we can print a little bit for debugging.

  puts "Found a story: upvotes=#{upvotes} title=#{title} category=#{category}"
  puts

  # Since our goal is just to save the important parts of each story
  # (the title, category, and upvote count), we'll be making our own
  # hash that represents that story. If we were saving these to a
  # database or something, we wouldn't care about all the little
  # details of what's in the Reddit API. We just want a simple, common
  # format for stories. That's why we're doing it this way.

  new_story = { :title => title, 
    :category => category, 
    :upvotes => upvotes 
  }

  # Then, we can push that new hash into our own stories array!

  stories.push( new_story )

  # Now we loop around and look at the next Reddit story.

end

# At the end of this loop, our 'stories' array contains just as many
# elements as we had in the reddit_stories array, except they're
# simple hashes we made instead of complicated hashes Reddit made.

# Goal 2 complete!

# 3. walk through our stories array and print out the "front page of
# Reddit" in the terminal

puts
puts
puts "Reddit (HOT!)"

# Now we can just print each story on the front page.

stories.each do |story|
	puts "#{story[:upvotes]} #{story[:title]} (#{story[:category]})"
end

# Yay!

