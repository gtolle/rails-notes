require "rest-client"
require "json"

require_relative "story"

class Teddit
  def download_stories
    # We're using 'limit=2' so we only get 2 stories. Easier to deal with.

    reddit_stories = JSON.load(RestClient.get("http://www.reddit.com/hot.json?limit=2"))

    @stories = []

    reddit_stories["data"]["children"].each do |reddit_story|

      new_story = Story.new
      
      new_story.title = reddit_story["data"]["title"]
      new_story.category = reddit_story["data"]["subreddit"]
      new_story.upvotes = reddit_story["data"]["score"]
      new_story.author = reddit_story["data"]["author"]
      
      # TO DO for practice: add support for comments!

      # The Reddit API also provides the ability to download the
      # comments for each story. 

      # Your goal is to download those comments, pick out the good
      # parts of each one (the author and the comment body), and store
      # the comments along with each story. Then, when you're printing
      # out the front page, print out the comments for each story also.

      # Here's what you'll have to do.

      # 1. Define a new Comment class with :author and :body
      # attributes. Remember, each class needs to go into its own
      # file. Look at Story, and make Comment like that (in a file, in
      # 'lib').

      # 2. Modify your Story class to have a new :comments attribute,
      # which will be used to hold an array of Comment objects.

      # 3. When you're looking at each story, download the comments
      # for that story using RestClient too.
      
      # Here's how you do it:

      # Each Reddit story has an identifier string in the "id" key of
      # the hash you get back in JSON. It'll look like "1xkkp3".

      # You can make _another_ REST API call to retrieve the comments
      # for any individual story, and you'll use that ID in order to tell
      # Reddit which story you want the comments for.

      # So, for each story, look at the 'id' key for the story, then interpolate
      # it into a new URL to use with RestClient.

      # http://www.reddit.com/comments/<FILL IN THE ID HERE>.json?limit=2

      # We're using limit=2 so we only get the top 2 comments. 

      # Now that you've made the URL, use the RestClient AGAIN to
      # download the list of comments for that story, and JSON.load to
      # decode it, just like before.

      # Once you get the comments object back, the Reddit comments
      # JSON looks like this, along with a bunch of other keys you
      # won't need.

      # [ 
      #   { repeated hash of article data }, 
      #	  { "data" => 
      #     { "children" => [ 
      #	      { "data" => { "author" => "jimbob", "body" => "hi!" }},
      #	      { "data" => { "author" => "fred", "body" => "bye!" }}
      #     ]}
      #   }
      # ]
      
      # 4. Now, initialize your new_story.comments array to [], so you
      # can push comments into it.
      
      # 5. In another loop right here, for each of the Reddit
      # comments, make a new Comment object, save the author and body
      # into that object's attributes, and then push that Comment
      # object into the new_story.comments array for the story you're
      # working with.

      # NOTE: The reddit comments also contain a field called
      # "replies", which has all the nested replies to the top-level
      # comments. Just ignore that field for now. Nested comments are
      # too complex for where we're at.

      # OK, NOW DO YOUR WORK RIGHT HERE. 

      # Have fun!

      @stories.push( new_story )
    end
  end
  
  def print_front_page
    @stories.each do |story|
      puts "#{story.upvotes} #{story.title} (#{story.category}) by #{story.author}, the modified upvotes are = #{story.modified_upvotes}"

      # After printing out each story, print out all the comments
      # associated with that story. You know, the ones you pushed into
      # that 'new_story.comments' array earlier. You'll need another
      # .each loop in here...
      
    end
  end
end

