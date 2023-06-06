# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Faker::Config.locale = :en


puts 'Generating categories...\n'
categories = 50.times.map do |i|
  print '.'
  Category.create! name: Faker::Commerce.unique.department
end

# puts categories.map(&:name)
puts 'Generating users...\n'
users = 30.times.map do |i| 
  print '.'
  User.create! name: Faker::Name.name, email: Faker::Internet.email, encrypted_password: '12345'
end

puts 'Generating lists...\n'
lists = 100.times.map do |i|
  print '.'
  List.create!(
    title: Faker::Lorem.sentence, 
    user: users.sample, 
    category: categories.sample,
    draft: true,
    items: (rand(8) + 3).times.map do |j|
      ListItem.new(
        external_api_identifier: Faker::IDNumber.valid,
        rank: j,
        title: Faker::Movie.title,
        # metadata: {x: 1, y: 2, z: 3},
        image_url: Faker::Internet.url,
        details: Faker::Date.between(from: '1920-09-23', to: '2023-09-25'),
        user_comment: Faker::Lorem.sentence(word_count: 15)
      )
    end
  )
end

puts "\nGenerating followers..."
users.each do |user|
  user.followers << (users - [user]).sample(rand(10) + 1)
end