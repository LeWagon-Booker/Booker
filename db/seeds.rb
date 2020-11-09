# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Cleaning database..."
Book.destroy_all
Family.destroy_all

puts 'Creating 20 fake books...'
20.times do
  book = Book.new(
    title:    Faker::Book.title,
    author: Faker::GreekPhilosophers.name,
    description:  Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
    category: Faker::Book.genre,
    year: rand(1995..2020),
    month: rand(1..12),
    image_url: 'https://images-na.ssl-images-amazon.com/images/I/71EwgGuAS9L._AC_SL1000_.jpg',
  )
  book.save!
end
puts 'Books Finished!'

puts 'Creating 2 families'
Family.create(name: "Let's read!")
Family.create(name: "Bxl's old ladies")
puts 'Families created'


