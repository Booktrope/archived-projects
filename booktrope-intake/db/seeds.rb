# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
"Action Adventure",
"Biography",
"Business",
"Chicklit",
"Children's",
"Christian Living",
"Coming Of Age",
"Contemporary Romance",
"Contemporary Women's Fiction",
"Erotica",
"Fantasy",
"Food",
"Health and Medicine",
"Healthy Living",
"Historical Fiction",
"Historical Romance",
"Horror",
"Humor",
"Law",
"LGBT",
"Literary Fiction",
"Memoir",
"Mystery",
"New Adult",
"Non-Fiction",
"Paranormal",
"Paranormal Romance",
"Psychology",
"Religion",
"Romance",
"Romantic Suspense",
"Science Fiction",
"Short Stories",
"Spirituality",
"Thriller",
"Urban Fantasy",
"Women's Contemporary Fiction",
"Young Adult",
"Young Adult Fantasy"].each do | genre |
	Genre.create(name: genre)
end

