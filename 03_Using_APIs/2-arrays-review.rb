# Let's start by creating an array and putting it in a variable so we
# can do something with it later.

pets = ["Fido", "Rover", "Fluffy"]

# Imagine that this list of 3 things exists out there in variable
# space now

# We can add new things to the end of the list with push

pets.push("Jones")

# We can walk through each item of the list with each. The |pet|
# argument to the 'do/end' block gets filled in by each of the items
# in the list, one by one, in order

# This is the easiest way to print each item in a list

pets.each do |pet|
	puts "My pet's name is #{pet}"
end

# But, we can put more than simple strings into arrays.

# Let's start by defining a hash with 2 keys. This hash describes my
# pet. We stored it in the 'my_pet' variable so we can do something
# with it later.

my_pet = { 
	:name => "Fido",
	:fur_color => "Brown"
}

# We can access those keys, print them, etc.

puts "My pet's name is #{my_pet[:name]} and its fur is #{my_pet[:fur_color]}"

# Let's define another hash with the same 2 keys.

my_other_pet = {
	:name => "Rover",
	:fur_color => "White"
}

puts "My pet's name is #{my_other_pet[:name]} and its fur is #{my_other_pet[:fur_color]}"

# Here's the cool part. We can define a whole array of hashes. This is
# how reddit stories, blog posts, and basically every other piece of
# content on the web works: it's an array of hashes (or objects), and
# the hashes hold the data about each item in the list.

pet_hashes = [
	{ :name => "Fido", :fur_color => "Brown"},
	{ :name => "Rover", :fur_color => "White"},
	{ :name => "Fluffy", :fur_color => "Black"}
]

# We saw push before. We can push a hash into an array too.

pet_hashes.push( { :name => "Jones", :fur_color => "Spotted" } )

# We can also push a hash that's in a variable

# This is how you'll be adding new content to your site - the user
# will submit data, you'll make a hash (an object, really), and you'll
# add it to a database

adopted_pet = { :name => "Tiny", :fur_color => "Calico" }
pet_hashes.push(adopted_pet)

# We can access the first hash in the array

first_hash = pet_hashes.first

puts "My pet's name is #{first_hash[:name]} and its fur is #{first_hash[:fur_color]}"

puts "--------"

# Or, we can walk through all the hashes in the array.

# This is how you'll display lists of content on your site. You'll ask
# the database for the content, you'll get back an array of hashes
# (objects, really), and you'll walk through the array to print them
# into the HTML page.

pet_hashes.each do |pet_hash|
	puts "My pet's name is #{pet_hash[:name]} and its fur is #{pet_hash[:fur_color]}"
end	

