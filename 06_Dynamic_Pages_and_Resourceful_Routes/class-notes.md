# Class Notes

# Resourceful Routes and Dynamic Pages

Most of the time, when you're writing Rails apps, you're building some
version of a "CRUD" app. 

CRUD stands for:

* Create
* Retrieve
* Update
* Delete

Think of Airbnb. On the site, you're typically Creating rooms, Retrieving a list of rooms, Retrieving a single room's details, Updating your room listing, and if you're sick of strangers staying on your couch, Deleting your listing.

Or, Twitter. You're Creating tweets, Retrieving a list of tweets, Retrieving a single tweet's details, not Updating old tweets because Twitter chose not to let you, and Deleting tweets you aren't proud of.

In Rails, there's a routing pattern that makes it super easy to create these CRUD apps.

Add a line like this to your config/routes.rb:

	resources :<plural name of your resource>
	
Like:

	resources :rooms
	
For a resource like ``:rooms``, this creates the following routes:

              rooms GET    /rooms(.:format)                   rooms#index
                    POST   /rooms(.:format)                   rooms#create
           new_room GET    /rooms/new(.:format)               rooms#new
          edit_room GET    /rooms/:id/edit(.:format)          rooms#edit
               room GET    /rooms/:id(.:format)               rooms#show
                    PATCH  /rooms/:id(.:format)               rooms#update
                    PUT    /rooms/:id(.:format)               rooms#update
                    DELETE /rooms/:id(.:format)               rooms#destroy

First of all, these routes are all handled by a single controller, also named after the resource. So make a ``rooms`` controller.

	rails generate controller rooms
	
Then, you can show a list of rooms on the ``/rooms`` url by defining the ``index`` 
method and the ``index.html.erb`` view for that ``rooms`` controller.

	http://www.airbnb.com/rooms
	
When you want to show a single room, you do it through a page like this

	https://www.airbnb.com/rooms/971069
	
And if you want to show a different room, you do it like this:

	https://www.airbnb.com/rooms/8739
	
Note that both of those pages look similar, and have URLs that are almost the same except for the number after ``/rooms``. 

Both of those pages are being rendered by the *same* controller action: the ``show`` action. 

Look at this route:

               room GET    /rooms/:id(.:format)               rooms#show

The ``:id`` part is a "URL parameter". Any URL that starts with ``/rooms/<something>`` will be handled by the ``show`` method in the ``rooms`` controller. The method can then look at that ``:id`` parameter and do something with it. In this case, Airbnb looks up that room in the database, and then passes the details about the room to the view. The view then renders the details of the specific room the user is looking at.

Then from the ``index`` page, Airbnb can link to each room by linking to ``/rooms/<id for that room>``.

More on the other routes besides ``index`` and ``show`` soon…

## Your first dynamic page

For our in-class app, we want to create a version of the secret numbers game that lets the user pick a number from a list by clicking a link, generate a random number, and show whether they picked the right number. 

This loosely fits into our CRUD pattern, so we'll create resourceful routes for the ``secret_numbers`` controller:

	resources :secret_numbers
	
We get the following routes:

         secret_numbers GET    /secret_numbers(.:format)          secret_numbers#index
                        POST   /secret_numbers(.:format)          secret_numbers#create
	  new_secret_number GET    /secret_numbers/new(.:format)      secret_numbers#new
 	 edit_secret_number GET    /secret_numbers/:id/edit(.:format) secret_numbers#edit
 	      secret_number GET    /secret_numbers/:id(.:format)      secret_numbers#show
    	                PATCH  /secret_numbers/:id(.:format)      secret_numbers#update
        	            PUT    /secret_numbers/:id(.:format)      secret_numbers#update
            	        DELETE /secret_numbers/:id(.:format)      secret_numbers#destroy

### Index

On the ``/secret_numbers`` page, the ``index`` page, we'll create our list of secret numbers. 

	http://localhost:3000/secret_numbers
	
When you link to this page from your homepage, you should use the path helper that goes along with the ``index`` route:

	<a href="<%= secret_numbers_path %>">Play the Secret Number Game</a>

From this page, we can link to the ``show`` action just like Airbnb does. If the user picks 2, we'll link them to:

	http://localhost:3000/secret_numbers/2

And if the user picks 3, we'll link them to:

	http://localhost:3000/secret_numbers/3

When you're making a link to a ``show`` page, you use the ``show`` path helper, except you give it an *argument*, like this:

	<%= secret_number_path( 2 ) %>
	
Becomes:

	/secret_numbers/2
	
And:

	<%= secret_number_path( 3 ) %>

Becomes:

	/secret_numbers/3
	
The path helper fills in the ``:id`` in the right place.

NOTE: the ``show`` path helper automatically gets the *singular* name of the resource. That's because you're looking at an individual "room", "tweet", or "secret number".

	<%= secret_number_path( 2 ) %> 
	
Not:

	<%= secret_numbers_path( 2 ) %>
	
If you want to render a list of links, you can use an ``each`` method in the view, like this:

	<% (1..5).each do |number| %>
	<a href="<%= secret_number_path( number ) %>">Choose Number <%= number %></a>
	<% end %>

This ``each`` method will also come in handy on our index pages later, for listing the elements of an array.

### Show

All of those links will call the same method: ``show``. In that method, you can get the specific ``:id`` by accessing the ``:id`` key of the ``params`` hash:

	def show
		@chosen_number = params[:id].to_i
		@secret_number = rand(5) + 1
		
		if @chosen_number == @secret_number
			@status = :win
		else
			@status = :loss
		end
	end
	
The ``params`` hash is always there inside of every controller method.

All the keys in this hash are strings, which means you can pass in a number like ``2`` or a name like ``rock``. If you want to do math on the number, you have to convert it into an integer with ``to_i``.

Then, you can save these params into a variable, write code to use them, etc. 

In this case, we're saving the number into an *instance* variable of the controller class. Any instance variable becomes available in the view, and you can render it into the page like this:

	<p>You chose <%= @chosen_number %>.</p>
	<p>Rails chose <%= @secret_number %>.</p>

Regular variables don't become available to the view -- only ``@instance`` variables.

In addition, you can't set your own @instance variables in the view - only in the controller, and you can only read them in the view.

We're also implementing the game logic in the controller to compare the two numbers.

Then, you can render the ``show`` page differently based on the result of the game by doing an ``if`` statement in the view:

	<% if @status == :win %>
	<h2>You won!</h2>
	<% elsif @status == :loss %>
	<h2>You lost. :(</h2>
	<% end %>

Here's the general rule:

> The method runs first, does the logic, and saves the results into @instance variables. 
> Then, the view runs, looks at the @instance variables, and displays the correct output.

## Private Controller Methods

By the way, when you're writing a piece of code in your controller that you want to call from multiple different controller methods, you can place it into a "private" method of the controller class. Place ``private`` on a line by itself, and all the methods after it are private. Private methods can't get connected to routes like your public action methods, but your action methods can call private methods. Private methods can also update @instance variables.

	class SecretNumbersController < ApplicationController  
		def index
			init_array
		end
		
		def show
			init_array
		end
		
		private
		
		def init_array
			@my_array = ["a", "b", "c"]
		end
	end

## Rock Paper Scissors Time!

