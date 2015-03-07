
# Class Notes

# Forms

## Or, how does my user actually tell things to my app?

We've talked a lot about producing information from your app. Showing pages, etc.

But whenever you want your user to send _you_ data, you'll probably end up using a **form** in one way or another.

## What's a form?

It's a set of HTML tags for creating text input boxes, text areas for composition, buttons, checkboxes, etc.

You could have a search form with one text field and a "Search" button.

Or, you could have a form that lets you provide the details for a new t-shirt by typing in a name, description, and filename.

Every form has to live on a specific HTML page.

That means you'll need to create your form inside of a view.

A user interacts with the form by filling it in. 

Each field of the form has a *name*, which is a string that your program will use to distinguish _that_ field from _any other_ field in the form.

Here's a sample form:

	Title: 
	[__________]   (we chose to name this field "title")
	Description:
	[__________________]  (we chose to the name this field "description")
	
	[Save]  (this is the "submit" button)

The HTML for this form would be roughly:

	<form>
		Title:<br>
		<input type="text" name="title">
		Description:<br>
		<input type="text" name="description">
		<input type="submit" value="Save">
	</form>
	
Here's another:

	[_________] [Search]   (we chose to name this field "q" for query)
	
And in HTML:
	
	<form>
		<input type="text" name="q">
		<input type="submit" value="Search">
	</form>
	
After filling in the fields of the form, the user *submits* it back to the server.

The form submission is controlled by two key attributes:

* an action, which is a URL that will receive the data the user types into the form when the user submits it
* a method, which indicates whether this form will be submitted using a POST or a GET

### GET forms vs POST forms

A GET form works by appending each field in the form to the URL in the query string, then GETing that URL. With our sample search form above, if the user typed "kittens" and action was `/search`, the URL would look like:

	/search?q=kittens

Our controller action behind `/search` can then access these query string parameters through the `params` hash, and use them for searching, etc.
	
A POST form works by sending the fields in the form to the URL, but doesn't put them in the URL themself. In general, most forms are POST forms, because a POST keeps the form data hidden and doesn't let you navigate to it again.

With our sample 'create' form above, if we POST it to this URL:

	/shirts
	
Then our controller action behind `POST /search` can also access the form fields by their `name` in the `params` hash.

Either way, you'll have to implement a controller action method that handles parameters from the GET or the POST.

### DELETE forms

Generally, the right way to delete an object is also through a form. Usually, this is a simple form with just a submit button, and an action that deletes the object when the user submits the form.

We like to do delete as a form instead of as a link because GETs are only supposed to be for retrieving information, not changing it. Would you want Google crawling your site and following your delete links?

## Rails Form Helpers

Rails includes a bunch of helper methods that generate all the HTML you'll need to create forms.

These helper methods come in two flavors:

* simple methods to generate a form without a model object
* richer methods to generate a form *based on* a specific model object

I strongly suggest you read the [Rails Guides on forms](http://guides.rubyonrails.org/form_helpers.html) to learn about all the different things that can go in a HTML form, and all the different Rails helpers that generate the HTML.
	
### Forms Without Models

When you're creating a GET form, like a search form, you'll use the simple form helpers.

	<%= form_tag root_path, :method => :get do %>
		<%= text_field_tag :q, params[:q] %>
		<%= submit_tag "Find Me Shirts" %>
	<% end %>
	
The `form_tag` helper takes the action URL as its first argument. When the user submits this form, the browser will reload the `root_path`, or `/` in this case, and fill in the value of the text field tag called `q` into the query string.

Try it yourself. Type this into the browser:

	localhost:3000/?q=greedo

It's the same as when the GET form gets submitted.

Common helper methods:
	
	form_tag - defines form
	text_field_tag - single line text input
	text_area_tag - multi line text input
	label_tag - printed text in a form
	check_box_tag - checkbox
	submit_tag - submit button
	
In every controller action, there's a variable called `params` that Rails makes for us. This variable is a *hash*, and it holds all of the form fields, query string params, and URL parameters that come from the user.

In our `index` controller action, we can access the string that the user typed into that text field (which we called `q`) through the params hash using the `:q` key, like this:

	params[:q]

### Forms With Models

More often, though, you're building a form which is designed to either *create a new model object* or *edit an existing model object*.

A model object has attributes with names.

A form has fields with names.

It's a match made in heaven!

In Rails, the 
	
	resources :shirts
	
route sets up two pages that should have forms on them:

	GET /shirts/new - has a form for creating a new shirt
	GET /shirts/:id/edit - has a form for editing the shirt identified by :id

The first is handled by the `new` action, and the second is handled by the `edit` action.

The `resources :shirts` route also sets up two additional pages that are just meant to handle the submission of forms.

When you submit a form on the `new` page, it gets handled by

	POST /shirts - handled by the `create` action

When you submit a form on the `edit` page, it gets handled by

	PUT /shirts/:id - handled by the `update` action

> The form on `new` goes to `create`, the form on `edit` goes to `update`.
	
On both the `new` and `edit` views, you'll want to use the `form_for` helper to create that form.

`form_tag` just makes a form. The `form_for` helper allows us to directly turn the attributes of a single model object into form fields. Which means you need to already have a model object, unlike with `form_tag`.

In your controller for `new`, we don't know what the user wants to put into the shirt yet, so you need to create a blank model object for `form_for`. 

	def new
		@shirt = Shirt.new
	end

And in your controller action for `edit`, you need to find an existing model object in the database before you call `form_for`, so the user can see what they're editing. `form_for` does this by pre-filling the current values of the model object into the form fields.
	
	def edit
		@shirt = Shirt.find(params[:id])
	end

So how do you use `form_for`:

	<%= form_for @shirt do |f| %>
		<div>
			<%= f.label :name, "Name of shirt" %><br>
			<%= f.text_field :name %>
		<div>
			<%= f.label :description, "Description" %><br>
			<%= f.text_field :description %>
		</div>
		<div>
			<%= f.label :image, "Image Filename" %><br>
			<%= f.text_field :image %>
		</div>
		<%= f.submit "Submit" %>
	<% end %>

`form_for` creates a "form builder object" which we call `f` here. Instead of calling bare helpers like `text_field_tag`, you need to call methods of that object, like `f.text_field`.

Common `form_for` methods (same names as the simple versions, without `_tag`):

	f.text_field
	f.text_area
	f.label
	f.check_box
	f.submit
	
The `form_for` helper ensures that all the fields for the `shirt` object will be stored in a nested hash inside of the `:shirt` key of the `params` hash.

So then, when the user submits this form, the controller action needs to get the values from the `params` hash like before, and do something with them.

For `create`, we need to use those parameters to fill in the attributes of a new model object and save it to the database.

	def create  
		@shirt = Shirt.new( params[:shirt] )
		@shirt.save
		redirect_to root_path
	end	
	
By the way, not all controller actions have views. Controller actions can also tell the browser to load a new URL immediately. This is called a "redirect".

After we save our new shirt object, the best practice is to redirect the browser to either the index page (e.g. `shirts_path` or `root_path`) or the details page for the new shirt (e.g. `shirt_path(shirt)`). That way, the user can see what they did.

**NOTE**: The simple code `Shirt.new(params[:shirt])` won't actually work in practice. Rails has a security feature called "Strong Parameters", which I'll talk about in a sec.

For `update`, we need to look up our model object again, update its attributes, save it, and then redirect the user to the detail page for the shirt we're editing, so they can see the new values.

	def update
		@shirt = Shirt.find(params[:id])
		@shirt.update( params[:shirt] )
		redirect_to shirt_path(@shirt)
	end

### Partials

It's really common to have the `new` form and the `edit` form being identical.

We could still write two forms, one in `new` and one in `edit`. But, we could also just write the form once and *include* it into both of those views.

We do that with "partials".

A partial is a snippet of a view that you can include into another view.

You place a partial into the `app/views/<some controller>` directory just like a view.

You name it with a filename that ends in `.html.erb` like a view, but you **have** to start it with `_`, like `_form.html.erb`. That `_` is how Rails knows it's a partial.

In that partial, you can put any HTML you want. It can access @-instance variables too. This is where we'll put our form from before.

You include the partial into another view with the `render` helper, like this:

	<%= render "sites/form" %>

This will render the partial in `app/views/sites/_form.html.erb`.

### Strong Parameters

If we just blindly accept whatever params the user sends us, then we're vulnerable to malicious users who try to hack our system by submitting their own forms with different field names.

For example, if we had a `User` object with an boolean true/false attribute `is_admin`, and if only users where `is_admin` is true can view other people's data, then imagine if a hacker user submitted a form for their own `User` record with `is_admin => true`. They'd become an admin!

Instead, we need to think about the form we built in the `new` or `edit` view, then list exactly which parameters we're allowing the user to send through that form.

We do this by calling methods on the `params` hash.

	params.require(:shirt).permit(:name, :description, :image)
	
`require`: this method checks if the `:shirt` key exists in the params hash. If not, it throws an error. If so, it pulls out the value of the `:shirt` key, which is another hash.

`permit`: this method checks if the inner hash contains any keys other than `:name`, `:description`, or `:image`. If so, it throws an error. If not, it just returns the hash, with a special internal flag saying that it's been checked.

So instead of 

	Shirt.new( params[:shirt] )
	
and

	Shirt.update( params[:shirt] )

We need to do:

	Shirt.new( params.require(:shirt).permit(:name, :description, :image) )

and

	Shirt.update( params.require(:shirt).permit(:name, :description, :image) )
	
But because we don't want to write these checks in two places, we should factor them out into a private controller method:

	Shirt.new( safe_shirt_params )
	
	Shirt.update( safe_shirt_params )
	
	private
	
	def safe_shirt_params
		params.require(:shirt).permit(:name, :description, :image)
	end
	
### Delete Buttons

There's an easy way in Rails to make a single-button form that deletes an object:

	<%= button_to "Delete Shirt", shirt_path(@shirt), :method => :delete %>

Here, we're making a button that submits to the `shirt_path` for a specific shirt, but with the DELETE method.

This will be handled by the `destroy` action in our controller:

	def destroy
		@shirt = Shirt.find(params[:id])
		@shirt.destroy
		redirect_to root_path
	end

We look up a shirt (from the URL `/shirts/18`), then we delete it, and we can't redirect to the detail page (because it's gone!) so we redirect to the index page instead.
