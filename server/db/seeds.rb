require 'faker'

20.times do |num|
  User.create!({
    name: Faker::Name.name ,
    username: Faker::Name.unique.name,
    email: "test#{num}@gmail.com",
    password: "123456"
  })
end

2.times do
  Tweet.create!({
    caption:  Faker::Lorem.paragraph_by_chars(number: 15),
    user_id: User.first
  })
end

2.times do
  Tweet.create!({
    caption:  Faker::Lorem.paragraph_by_chars(number: 15),
    user_id: User.second
  })
end

6.times do
  Tweet.create!({
    caption:  Faker::Lorem.paragraph_by_chars(number: 15),
    user_id: User.last
  })
end

