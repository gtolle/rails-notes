# Class Notes
# Validations and Authentication

Skip down to get to the authentication part.

# Validations

Think about your Movie app. 

If someone's creating a new movie, they can easily hit the 'create' button by accident without filling in the Title, Description, or Year Released.

Then you have a movie with no data! That's no fun.

How to prevent this?

Set up a _validation_ rule that requires the Title, Description, and Year Released fields of a Movie model to at least have *something* in them. If any of those fields aren't filled in, don't let the new model object get saved into the database.

There are lots of things you can validate about an attribute of a model:

* presence of anything at all
* the length of this string must be greater than 10
* this must be a number
* this number must be greater than 0
* etc…

For a full list, see the [Active Record Validations](http://guides.rubyonrails.org/active_record_validations.html) Rails Guide.

To implement validations, you need to touch 3 parts of your app:

* In the model, pick the field and condition, and add the rule.
* In the controller, check if the model is valid on save, and show the form again if it's not.
* In the view, show the errors that are preventing the model from being valid to the user.

## Model

Each validation rule uses the `validates` method inside the class of the model you want to validate.

	class Movie < ActiveRecord::Base
		  validates :title, :description, :year_released, :rating, :presence => true
	end
	
`validates` takes a list of names of attributes of the model, and then a hash of rules to check. Each rule has different options.

Here are some self-explanatory examples:

	:presence => true
	:length => { :minimum => 10 }
	:numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
	:numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 }
	
For a full list, see the [Active Record Validations](http://guides.rubyonrails.org/active_record_validations.html) Rails Guide.

Rails will automatically check each validation rule whenever you try to create, update, or save a model. If the model isn't valid, the `save`, `create`, or `update` method will return `false` and the model won't save. Your database is protected!

You can check for this `false` in your controller.

## Controller

The usual Rails pattern works like this (for the `create` action):

	def create
    	@movie = Movie.new safe_movie_params

    	if @movie.save
	      redirect_to @movie
	    else
	      render 'new'
	    end
	end
	
If the movie is valid and saves OK, then redirect the browser and show the movie page like normal.

If the movie IS NOT valid, then show the user the 'new' page again. This 'new' page will show the form again, and because there's an @movie variable that has been partially filled in with data, the user's data will be shown in the `form_for` again.

Same for `update`:

	def update
    	if @movie.update(safe_movie_params)
	      redirect_to @movie
	    else
	      render 'edit'
	    end
	end
	
Just follow this pattern and don't forget to check if the model saves or updates. You'll be golden.

## View

Rails generates a bunch of pretty good error messages whenever a validation fails. They're based on the field name and the validation rule. If you have a rule that says 

	validates :title, :presence => true
	
Then the automatic full error message will be:

	Title can't be blank.
	
Pretty good, right?

The easiest way to tell the user what's wrong is to print those error messages on top of the form, but only if the model has errors.

	<% if @movie.errors.any? %>
  		<h2>There were errors saving your movie</h2>
	    <ul>
    	  <% @movie.errors.full_messages.each do |msg| %>
      		<li><%= msg %></li>
    	  <% end %>
 		</ul>
    <% end %>

	<%= form_for @movie do |f| %>
	 …
	<% end %>

If you want to format them your own way, then check out the [Active Record Validations](http://guides.rubyonrails.org/active_record_validations.html) Rails Guide to see how.

So now with validations, the user will:

* try to create or edit a model
* miss a field or get one wrong
* hit the submit button
* see the form again, with their original input, and a bunch of errors on top telling them what's wrong
* fix the errors
* submit the form
* carry on their usual way

Pretty good, right?

Better than movies with no titles (Movies), urls with no links (Ritly), and stories with no categories (Rewsly)!

# Authentication

Imagine you're the doorman at The Battery (thebattery.com), an exclusive club.

Someone is hanging out in the lobby, but wants to get into the private part of the club.

It costs $2400 to get into the club. 

Your job is to make sure they've paid before letting them in.

## Managing Users

In your club, you'll have a guest list of authorized users. 

In Rails, users are just one more kind of model stored in the database. The model is called User, and they're stored in the "users" table.

|id|name  |email  |
|:--|:-----|:------|
| | | |

Matt Kowalsky comes along and tries to get into the club.

You ask him what his name is.

> Matt Kowalsky

You check if his name is on the list.

If it isn't, you ask him to pay you $2400, and then you'll put him on the list.

|id|name  |email  |
|:--|:-----|:------|
|1| Matt Kowalsky | mkowalsky@nasa.gov |

Then, you ask what his name is:

> Matt Kowalsky

It's on the list!

It's now 9:00pm. You hand him a cookie for `thebattery.com` that says:

	Admit User #: 1
	Good Until: 9:15pm

Then every time he comes back to the club (loads another page), he presents the cookie, and you make sure the cookie is still valid (it's not 9:15pm yet).

If so, you look up user 1, see that he's still on the guest list, then let him in.

We can admit someone else to the club using the same technique:

|id|name  |email  |
|:--|:-----|:------|
|1| Matt Kowalsky | mkowalsky@nasa.gov |
|2| Ryan Stone  | rstone@nasa.gov |

Ryan gets her own cookie with her own user ID.

But, let's say that someone else (Dee Bris) wants to get into the club.

What's your name?

> Dee Bris

Sorry, you're not on the guest list. Pay $2400.

> Oh, my name is Matt Kowalsky

You check if they're on the guest list. They are.

Come on in!

This is why we need secret _passwords_ - to stop people from easily impersonating each other.

## Passwords

Let's enhance the guest list with a password:

|id|name  |email  | password |
|:--|:-----|:------|----------|
| | | | |

What's your name? "Matt Kowalsky". Not on the list. Pay up. "Here you go". OK, now tell me a secret password that only you know. "gravity". Great. You're in.

|id|name  |email  | password |
|:--|:-----|:------|----------|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | gravity |

Next time Matt comes back:

What's your name "Matt Kowalsky". You're on the list. What's your password? "gravity". Great, it matches. Come on in.

And Ryan:

|id|name  |email  | password |
|:--|:-----|:------|----------|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | gravity |
|2| Ryan Stone  | rstone@nasa.gov | hubble |

Now, Dee Bris comes along and tries to sneak in as Matt.

Name?

> Matt Kowalsky

OK, you're on the list. Your password?

> Uhhh…

But, Dee is clever. She breaks in and steals the guest list. The guest list has the passwords on it. Now she knows Matt's password, and everyone else's password. She can get into the club as anyone.

And if Matt or Ryan used that password on other sites, Dee can get into those sites too.

__Never Do This__. __Don't store passwords in your database__. __Just don't__.

There's a better way:

## Hashed Passwords

A hash is a cryptographic function that takes some data as input (like a string) and transforms it into a random, unique, short hash code. 

In general, the chance of any two strings hashing to the same code should be extremely tiny (like, atoms in the universe tiny). So you can treat the hash code as uniquely associated with the string.

But, there should be _no_ easy way to use the function in reverse. You can't take a hash code and turn it back into the string. It's not encryption, where you can encrypt and decrypt each string as long as you know the key. It's hashing. There is no key.

If you wanted to reverse the hash, you could pick a string to try, hash it, and see if it matches the hash code. If so, you know the string! If not, you try another string. You just keep guessing until you figure it out.

We can use hashing to authenticate our users using passwords _without_ storing them:

|id|name  |email  | hashed_password |
|:--|:-----|:------|----------|
| | | | |

What's your name? "Matt Kowalsky". Not on the list. Pay up. "Here you go". OK, now tell me a secret password that only you know. "gravity". Great. You're in.

Now, we take Matt's password and "hash" it. SHA1 (Secure Hash Algorithm 1) is our hash function for this example, but this isn't a good hash function for real passwords (BCrypt or PBKDF2 are better). SHA1 is too fast to compute, so it's too easy to do a bunch of guesses. But I'll use it in this demo. I'll also only show the first few chars in my tables, but SHA1 hashes are much longer.

	1.9.3p392 :001 > Digest::SHA1.hexdigest("gravity")
	 => "ada87b6cd2a041a35f6b3f19b418f10a454a799f" 

|id|name  |email  | hashed_password |
|:--|:-----|:------|----------|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | ada8 |

We admit Ryan too. Her password is "hubble".

	1.9.3p392 :003 > Digest::SHA1.hexdigest("hubble")
	 => "271c5d7ca1765b52a29bff8278dee02c324f54d5" 

|id|name  |email  | hashed_password |
|:--|:-----|:------|----------|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | ada8 |
|2| Ryan Stone  | rstone@nasa.gov | 271c |

Now, the next time Matt comes along and wants to get in:

What's your name "Matt Kowalsky". You're on the list. What's your password? "gravity". 

We hash it. 

	1.9.3p392 :001 > Digest::SHA1.hexdigest("gravity")
	 => "ada87b6cd2a041a35f6b3f19b418f10a454a799f" 

We check the hash against the database entry for Matt.

	ada8
	
Great, it matches. You're in.

We can admit Ryan the same way:

	1.9.3p392 :001 > Digest::SHA1.hexdigest("hubble")
	 => "271c5d7ca1765b52a29bff8278dee02c324f54d5" 

Great, it matches.

Let's say Dee Bris steals the guest list and tries to get in now.

What's your name?

> Matt Kowalsky

What's your password?

> Uhh, "ada8".

	1.9.3p392 :001 > Digest::SHA1.hexdigest("ada87b6cd2a041a35f6b3f19b418f10a454a799f")
	 => "ea96c5983e83100484a1c1d64ffaf3fbb96b9232" 

Nope, `ea96` doesn't match `ada8` in the database. You're not Matt. You can't get in.

Good news, everybody!

But, there's another problem. Let's say multiple people pick "gravity" as a password. "gravity" always hashes to "ada8".

|id|name  |email  | hashed_password |
|:--|:-----|:------|----------|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | ada8 |
|2| Ryan Stone  | rstone@nasa.gov | 271c |
|3| Shariff  | shariff@nasa.gov | ada8 |

Let's say it leaks out that Matt's password is "gravity". Now, Dee Bris knows that Shariff's password is _also_ "gravity", just by looking at the list. Whoops.

And let's say that Matt used "gravity" on other sites, and those sites also used the standard SHA1 hash. Now, they know everyone else on that site who used "gravity" as a password. Double whoops.

Or if there's a big list of words floating around that says "gravity" hashes to `ada8` and "hubble" hashes to `271c`, then we just look each hash up in the list, and bam. We crack everyone who was silly enough to choose a password on that list. Triple whoops.

There's a better way:

## Salted and Hashed Passwords

To make our passwords tastier (and more secure), let's add a little salt to each one before we hash it.

A salt is a random number that we concatenate with the password before hashing. We store the salt along with the user entry, like this:

|id|name  |email  | hashed_password | salt
|:--|:-----|:------|----------|----|
| | | | | |

What's your name? "Matt Kowalsky". Not on the list. Pay up. "Here you go". OK, now tell me a secret password that only you know. "gravity". Great. You're in.

Now we generate a new salt for Matt.

	1.9.3p392 :006 > SecureRandom.hex(20)
 	  => "467dbb4a800f1c475acb3e20d951497d66937dad" 

Then we add that salt into Matt's password before hashing it:

	1.9.3p392 :007 > Digest::SHA1.hexdigest("gravity" + "467dbb4a800f1c475acb3e20d951497d66937dad")
	 => "a8c57cb9c7cb035270857fc2a58f64abad85a580" 

Then we store the hash and the salt:

|id|name  |email  | hashed_password | salt
|:--|:-----|:------|----------|----|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | a8c5 | 467d |

And Ryan, with "hubble":

|id|name  |email  | hashed_password | salt
|:--|:-----|:------|----------|----|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | a8c5 | 467d |
|2| Ryan Stone  | rstone@nasa.gov | 2186 |  c016 |

So now when Matt comes back:

What's your name? "Matt Kowalsky". You're on the list. What's your password? "gravity". 

We look up the salt in our database, then we hash it with the password again:

	1.9.3p392 :010 > Digest::SHA1.hexdigest("gravity" + "467dbb4a800f1c475acb3e20d951497d66937dad")
	 => "a8c57cb9c7cb035270857fc2a58f64abad85a580" 

Great, `a8c5` matches our database entry for Matt.

Let's add Shariff, with his password "gravity". He gets a different random salt.

	1.9.3p392 :012 > Digest::SHA1.hexdigest("gravity" + "d5c1f5997c071337aa10e7844be4a5106dff7b14")
	 => "dea82bdee30dbde81741c1daafb0241c93a10ddb" 


|id|name  |email  | hashed_password | salt
|:--|:-----|:------|----------|----|
| 1 | Matt Kowalsky | mkowalsky@nasa.gov | a8c5 | 467d |
|2| Ryan Stone  | rstone@nasa.gov | 2186 |  c016 |
|3| Shariff  | shariff@nasa.gov | dea8 | d5c1 |

Now, if Dee Bris steals the list and figures out that Matt's password is "gravity" she still can't tell that Shariff's password is also "gravity". Matt's hash is `a8c5` and Shariff's hash is `dea8`. 

Dee just has to keep guessing at each individual person's password separately, and can't look them up in a big table either. Great! Salt makes everything better.

### Cookie theft

But, if Dee really wants to get into the site, but can't crack the password hashes or can't steal the password list, she can still try to steal a cookie that Matt, Ryan, or Shariff have already been given by the site.

Then, she can show that cookie to the server, and get right into the site.

Normally, these cookies live on your laptop. Dee could steal the laptop.

Or, she could use a "cross-site scripting" attack which tricks your browser into sending your cookie to Dee's server instead of to thebattery.com. Then, she can use your cookie.

The cookies have a time limit on them to hopefully restrict how much damage Dee can do. But, it's up to the server how long the cookie lasts. If you're a bank, you probably set it to 15 mins. If you're a less secure site, you might set it to 1 year.

### Other attacks

Or, Dee can install a keylogging program on your laptop and wait for you to type the password.

Or, she can sniff your traffic in the middle.

Or a ton of other stuff.

There are lots of ways to try and get around authentication. I'd suggest doing some reading on security, if you're interested.

## Why learn this?

It's good to know how secure authentication works. But, there are lots more little details that can go wrong (e.g. picking a good slow hash function). The main reason I'm teaching this is to say:

__Don't Try To Implement This Yourself__

There's a 99% chance you'll get it wrong, and then you'll have to issue a bunch of embarrassing press releases like Adobe (they used encryption instead of hashing, no salt, 150 million passwords leaked) or LinkedIn (they used fast SHA1 hash with no salt, 8 million passwords leaked), or Cupid Media (they leaked 42 million _plaintext_ passwords with no hash, salt, nothing) a few years down the line.

Instead, use an authentication package that someone else has already written.

In Rails, the current best package is a gem called Devise.

## Devise

Devise is a gem that:

* creates a User model and "users" table
* handles secure password authentication and storage
* gives out cookies when users log in
* checks those cookies when users come back
* looks up the right User model and makes it available to your code
* gives you default controllers and view pages for "log in" and "sign up"
* lets you protect specific controller actions so they're only usable if you're logged in (e.g., you're in the club)
	
It's wonderful.
	
Read the [Devise Docs](https://github.com/plataformatec/devise) to get all the details. This is just a summary.

### Adding Devise

Devise is a gem, so you'll add it to your app the usual way:

	$ subl Gemfile
	
	gem 'devise'
	
	$ bundle install
	
Then, you'll take two steps to add Devise to your app:
	
	$ rails generate devise:install
	
This adds some basic Devise config files to your app.

	$ rails generate devise user

This adds a migration to create the "users" table with the default columns (`email` and `encrypted_password`, which holds the salt and the hashed password concatenated together). The "users" table also has a bunch of other columns, which Devise manages for you.

And, this creates a User model class.

Now, create your users table:

	$ rake db:migrate

Your app is now ready to start tracking users and doing authentication.

### Letting users sign up and log in

Look at every website with authentication. There are probably 2 links in the upper right corner: "log in", and "sign up".

You'll have to add those links to your app too.

To make sure they're present on every page, you should add them to your application layout.

	$ subl app/views/layouts/application.html.erb
	
Add code like this, if you're not using Bootstrap yet. If you're using the Bootstrap nav bar, then add these links as list elements pulled to the right.

	<div style="float: right;">
		<a href="<%= new_user_session_path %>">Log In</a> |
	 	<a href="<%= new_user_registration_path %>">Sign Up</a>
	</div>
	
See those two routes? `new_user_session_path` and `new_user_registration_path`? Those are routes that Devise adds for you automatically by adding this line to your `routes.rb`:

	devise_for :users

To see all the routes that Devise handles for you, run `rake routes`

	                  Prefix Verb   URI Pattern                    Controller#Action
        new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
            user_session POST   /users/sign_in(.:format)       devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
           user_password POST   /users/password(.:format)      devise/passwords#create
       new_user_password GET    /users/password/new(.:format)  devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
                         PATCH  /users/password(.:format)      devise/passwords#update
                         PUT    /users/password(.:format)      devise/passwords#update
                         
	cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
	       user_registration POST   /users(.:format)               devise/registrations#create
	   new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
	  edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
	                         PATCH  /users(.:format)               devise/registrations#update
	                         PUT    /users(.:format)               devise/registrations#update
	                         DELETE /users(.:format)               devise/registrations#destroy

Here are those two routes:

	        new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
	   new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new

Try it in your own app.

Look! Devise comes with its own standard views for signing in and signing up!

You can use them right away.

### Showing Devise flash messages

Devise also alerts the user through the "flash" if the user messes up their password, or doesn't fill in an email address, etc.

The flash is a Rails method for storing a temporary message that will be shown to the user on the next page load.

To show those messages, you need to add these lines to your `application.html.erb`;

	$ subl app/views/layouts/application.html.erb
	
	<%= notice %>
	<%= alert %>
	
You'll have to format the messages yourself.

If you're using Bootstrap, add this line instead. It's formatted more nicely:

	<%= bootstrap_flash %>

Now, try signing up. You'll see a new entry in your "users" table. Now try logging in. It works!

### Showing that users are signed in

But, look at every web app out there. Once you log in, the 'log in' and 'sign up' links go away, and they're replaced by the user's name, username, or email address, and a 'log out' link.

Here's how you do this in Devise.

Devise provides 2 helper methods:

	user_signed_in?
	current_user
	
`user_signed_in?` is true whenever the user is logged in, and false otherwise. That's how we pick what to show. 

`current_user` is automatically filled in with the User model for the logged-in user. Devise does that for us. That's how we'll get the email address to show.

You can use these methods in ANY view and in ANY controller.

For now, we'll just use them in your layout.

Edit your `application.html.erb` and replace that code with this:

	<div style="float: right;">
	  <% if user_signed_in? %>
	  	Hi, <%= current_user.email %>
		<%= link_to "Log Out", destroy_user_session_path, :method => :delete %>
	  <% else %>
	  	<a href="<%= new_user_session_path %>">Log In</a>
	  	<a href="<%= new_user_registration_path %>">Sign Up</a>
	  <% end %>
	</div>
	
Now, you'll see that if the user is signed in, we show their email address and a log out link. The 'log out' link is a bit special - just use the 'link_to' helper with ':method => :delete' and you'll be fine.

### Protecting controller actions

Once you have authenticated users, you can restrict access to different parts of your site.

First, think about what you want to restrict access to.

Let's say we want to make it so that only logged-in users can add new stories to Rewsly.

You'll need to protect the `new` action in the `stories` controller _AND_ the `create` action. Don't forget to protect both, or else a user can just submit their own form to `create` and bypass your authentication.

You protect a controller action by adding a `before_action` to that controller, and specifying the actions that it runs … before.

A `before_action` is just a method that runs before a controller action. Devise gives you a method called `authenticate_user!` that checks if a user's authenticated.

	class StoriesController < ApplicationController

		before_action :authenticate_user!, :only => [:new, :create]

		def index
		…
		
		def new
		…
		
		def create
		… 
	end
	
If the user tries to load a protected page (e.g. by clicking the "Add New Story" link) but isn't authenticated, Devise will automatically redirect them to the "log in" page and ask them to log in. If they log in OK, then Devise will take them right back to the page they were going to in the first place (e.g. the "new story" form).

Try it out in your app.

Now, your club has a doorman and a guest list! 

And with only a few lines of code, thanks to Devise.

### Customizing Devise views

If you don't like the default 'log in' and 'sign up' views that come with Devise, you can run this command to copy the views into your own app so you can customize them:

	$ rails generate devise:views
	
Now, look for the new views in your `app/views` directory and edit as you see fit.

As always, see the [Devise Docs](https://github.com/plataformatec/devise) for more details.

# Next Class: Associating models with other models, so you can say "this user posted these stories" and "that user posted those stories"
