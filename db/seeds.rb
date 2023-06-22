Faker::Config.locale = :en


# possible_categories = ["Filmes", "Séries", "Pessoas"]
# categories = possible_categories.map do |i|
#   print '.'
#   Category.create! name: i
# end


User.create! name: "testUser5", email: "test@user5.com.com", password: '12345'
User.create! name: "testUser7", email: "test@user7.com", password: '12345'
