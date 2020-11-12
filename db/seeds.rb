# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"


CATEGORIES = ["Fantasy",
 "Adventure",
 "Romance",
 "Contemporary",
 "Dystopian",
 "Mystery",
 "Horror",
 "Thriller",
 "Paranormal",
 "Science-Fiction",
 "Cooking",
 "Art",
 "Personal",
 "Motivational",
 "Health",
 "History",
 "Travel",
 "Humor",
 "Children’s",
 "Business",
 "Entrepreneurship",
 "Manga",
 "BD",
 "Comic"]

puts "Cleaning database..."
Book.destroy_all
Family.destroy_all
Category.destroy_all
puts 'Creating catergories...'

CATEGORIES.each do |category|
  Category.create(name: category)
end



puts 'Creating 20 fake books...'
20.times do
  book = Book.new(
    title:    Faker::Book.title,
    author: Faker::GreekPhilosophers.name,
    description:  Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
    year: rand(1995..2020),
    month: rand(1..12),
    user_id: User.last.id
  )
  file = URI.open("https://picsum.photos/200/300")
  book.cover.attach(io: file, filename: 'cover.png', content_type: 'image/png')
  book.category = Category.all.sample()
  book.save!
end
puts 'Books Finished!'

puts 'Creating 2 families'
Family.create(name: "Let's read!")
Family.create(name: "Bxl's old ladies")
puts 'Families created'


