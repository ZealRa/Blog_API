require 'faker'

puts "Deleting old articles..."
Article.destroy_all

puts "Creating articles..."
30.times do
  Article.create(
    title: Faker::Book.title,
    content: Faker::ChuckNorris.fact
  )
end

puts "Seeded #{Article.count} articles!"
