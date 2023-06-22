Faker::Config.locale = :en


possible_categories = ["Filmes", "Séries", "Pessoas"]
categories = possible_categories.map do |i|
  print '.'
  Category.create! name: i
end


User.create! name: "testUser2", email: "test@user2.com.com", password: '12345'
User.create! name: "testUser3", email: "test@user3.com", password: '12345'
