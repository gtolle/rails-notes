# Here's where we define the Story class. 

class Story
  # We use the 'attr_accessor' method to define attributes of the
  # class. Each attribute gets named with a symbol
  # (e.g. :title). Then, you can call a method to access it from
  # outside the class, and you can assign to that attribute using '='.

  # We started by defining 3 key attributes. :title, :category, and :upvotes

  # Then, I asked everyone to define a fourth: :author
  attr_accessor :title, :category, :upvotes, :author

  # The data in these attributes is stored in what's called an
  # 'instance variable'. An instance variable is like a regular
  # variable you define (e.g. 'x = 3'), but it exists inside the
  # object, and it can be accessed by all the methods defined in that
  # object. An instance variable is prefixed with an @-sign, like @title.

  # By way of explanation, saying 'attr_accessor :title' is just like
  # defining these two methods. The first one returns the contents of
  # the instance variable of the the same name. The second one stores
  # things into the instance variable.

  # def title
  #   return @title
  # end	
  
  # def title=(new_title)
  #   @title = new_title
  # end
  
  # This method accesses the object's own attributes, using
  # "self.<attribute>", and examines their contents before returning
  # different values.

  # You'll be doing this kind of stuff a lot with Rails models.

  def modified_upvotes
    if self.title.include?("NSFW")
      return self.upvotes / 10
    elsif self.title.downcase.include?("halloween")
      return self.upvotes * 10
    else
      return self.upvotes
    end
  end
end
