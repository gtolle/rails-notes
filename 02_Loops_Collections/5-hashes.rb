# We powered through arrays, which are how you keep track of lists in
# Ruby.

# Hashes are how you represent, for lack of a better word, "complex
# things". Think of a listing on airbnb. It has a title, it also has
# the name of the host, it has the price of the room, it has
# amenities, it has a bunch of other things.

# You could use separate variables for all this, but that would get
# tedious quickly, and you still couldn't have multiple of them.

# Instead, you use a hash.

# Think of a hash like a little two-column spreadsheet existing out
# there in variable space. The left column holds 'keys', which are
# names for parts of the complex thing, and the right column holds a
# value for each key.

# You defined an array with square brackets. You define a hash with
# curly braces. Then, you have a list of key-value pairs. Each key
# usually starts with a colon, which is called a 'symbol' in ruby, and
# then you use the 'arrow', (equal sign plus angle bracket), and then
# you put the value. The value could be a string, but it could also be
# a number, or anything else (even an array or another hash or an object).

{
	:title => "Sunny Room in the Mission",
	:host_name => "Gilman Tolle",
	:price => 120,
	:amenities => "Indoor bathroom, Non-leaking roof"
}

# But again, to _do_ anything with the hash, you need to assign it to
# a variable.

airbnb_listing = {
	:title => "Sunny Room in the Mission",
	:host_name => "Gilman Tolle",
	:price => 120,
	:amenities => "Indoor bathroom, Non-leaking roof"
}

# Then, you can ask the hash for "the value of this given key", and
# it'll give the value back to you. 

# You access a hash value with square brackets, kind of like an array,
# but instead of putting in a number, you put in a symbol. 

# Then, you can use the value you get back in a formatted string.

puts "The host's name is #{airbnb_listing[:host_name]}"

# You'll be doing this _all the time_ in the webapps you write. Pull
# out the parts of a hash (or an object), and format them into the
# right places in your HTML document.

# Remember how we walked through each array element with 'each'? You
# can do that with hashes too. Except each element has a key _AND_ a
# value, so the block gets two arguments. I called them 'key' and
# 'value' here.

airbnb_listing.each do |key, value|
	puts "The listing's #{key} is #{value}"
end

# Inspect works for hashes too. Good for debugging.

puts "The listing is #{airbnb_listing.inspect}"

# The other awesome thing about hashes is that you can _change_ what's
# inside each item. Let's say my listing gets popular, and I want to
# raise the price.

puts "I'm popular now"

# Remember how we accessed a hash value with square brackets? You can
# also assign a hash value with square brackets, but you do it on the
# LEFT side of the equal sign.

airbnb_listing[:price] = 150

# After this line, you've changed the hash value in place. The old
# '120' is wiped away, and the price is now '150'.

airbnb_listing.each do |key, value|
	puts "The listing's #{key} is #{value}"
end

puts "The price is #{airbnb_listing[:price]}"

# And, you can even add totally new items to a hash in-place. Let's
# say I want to start keeping track of whether these listings have
# pools. My house has one. That's cool.

puts "My house has a pool now"

# Here, I'm assigning a key that I _didn't originally put into the
# hash_ when I defined it. That's totally fine. Ruby just creates a
# new row in our two-column spreadsheet, and sets the key and value
# for me.

airbnb_listing[:has_swimming_pool] = true

# Then I can get it back!

airbnb_listing.each do |key, value|
	puts "The listing's #{key} is #{value}"
end

# Next time, we'll talk about arrays of hashes, arrays _IN_ hashes,
# and even hashes in hashes. And we'll do a fun lab where we get to
# work with JSON APIs from live sites.
