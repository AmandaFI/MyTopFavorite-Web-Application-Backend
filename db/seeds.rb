Faker::Config.locale = :en


possible_categories = ["Filmes", "Séries", "Pessoas"]
categories = possible_categories.map do |i|
  print '.'
  Category.create! name: i
end


User.create! name: "afi", email: "a@fi.com", password: '12345'
User.create! name: "testUser", email: "test@user.com", password: '12345'
