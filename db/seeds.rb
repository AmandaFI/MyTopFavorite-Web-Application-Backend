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
  User.create! name: Faker::Name.name, email: Faker::Internet.email, password: '12345'
end

fake_urls = ['/wXqWR7dHncNRbxoEGybEy7QTe9h.jpg', '/wXqWR7dHncNRbxoEGybEy7QTe9h.jpg', '/9vaRPXj44Q2meHgt3VVfQufiHOJ.jpg', '/ay7xwXn1G9fzX9TUBlkGA584rGi.jpg', '/fNOH9f1aA7XRTzl1sAOx9iF553Q.jpg', '/oU7Oq2kFAAlGqbU4VoAE36g4hoI.jpg', '/momkKuWburNTqKBF6ez7rvhYVhE.jpg', '/oOleziEempUPu96jkGs0Pj6tKxj.jpg', '/snGwr2gag4Fcgx2OGmH9otl6ofW.jpg', '/hEjK9A9BkNXejFW4tfacVAEHtkn.jpg', '/y5Va1WXDX6nZElVirPrGxf6w99B.jpg', '/Nkgaj3X0W2jHQ1TzHEgWFpN3kJ.jpg', '/sizg1AU8f8JDZX4QIgE4pjUMBvx.jpg', '/yFihWxQcmqcaBR31QM6Y8gT6aYV.jpg', '/ei2qjTiDpgKGuoSEntPCSAIhuvQ.jpg']

puts 'Generating lists...\n'
lists = 100.times.map do |i|
  print '.'
  List.create!(
    title: Faker::Lorem.sentence, 
    user: users.sample, 
    category: categories.sample,
    draft: Faker::Boolean.boolean,
    items: (rand(8) + 3).times.map do |j|
      ListItem.new(
        external_api_identifier: Faker::IDNumber.valid,
        rank: j,
        title: Faker::Movie.title,
        # metadata: {x: 1, y: 2, z: 3},
        # image_url: Faker::Internet.url,
        image_url: fake_urls.sample,
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