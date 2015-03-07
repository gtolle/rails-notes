# Just like we did at the top level before, we need to require the
# libraries we want to use. It's better to require them inside the
# file that will use them (e.g. here in teddit.rb) than at the
# top-level in 'teddit-driver.rb'.

require "rest-client"
require "json"

# We also need to bring in our Story class, just like we did at the
# top level.

# Except this time, because this file ('teddit.rb') is in the same
# directory as the story.rb file, require_relative can just load
# "story" directly instead of with "lib/story".

require_relative "story"

class Teddit
  def download_stories

    # 1. First, we'll download the stories and convert them from JSON.
    
    reddit_stories = JSON.load(RestClient.get("http://www.reddit.com/hot.json"))

    # Now, we're going to create our 'stories' array as an instance
    # variable, so we can access it from both the download_stories
    # method and from the print_front_page method. The
    # download_stories method will initialize it and fill it up, and
    # the print_front_page method will access it.

    @stories = []
    
    # 2. Go through each item in reddit_stories and create a new Story object
    
    reddit_stories["data"]["children"].each do |reddit_story|

      # This is the same object stuff as before.

      new_story = Story.new                             # kinda like new_story = {}
      
      new_story.title = reddit_story["data"]["title"]   # kinda like new_story[:title] = reddit_story["data"]["title"]
      new_story.category = reddit_story["data"]["subreddit"]
      new_story.upvotes = reddit_story["data"]["score"]
      new_story.author = reddit_story["data"]["author"]
      
      # 3. Push that Story object into @stories
      
      @stories.push( new_story )
    end
  end
  
  def print_front_page

    # Now, we'll go through each item in @stories and print it out
    
    @stories.each do |story|
      puts "#{story.upvotes} #{story.title} (#{story.category}) by #{story.author}, the modified upvotes are = #{story.modified_upvotes}"
    end
  end
end
