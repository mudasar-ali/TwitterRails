require 'faker'

20.times do
  User.create!({
    name: Faker::Name.name ,
    username: Faker::Name.unique.name,
    email: "#{Faker::Internet.user_name}@gmail.com",
    password: "123456"
  })
end

2.times do
  Tweet.create!({
    caption:  Faker::Lorem.paragraph_by_chars(number: 15),
    user_id: 115
  })
end

2.times do
  Tweet.create!({
    caption:  Faker::Lorem.paragraph_by_chars(number: 15),
    user_id: 120
  })
end

6.times do
  Tweet.create!({
    caption:  Faker::Lorem.paragraph_by_chars(number: 15),
    user_id: 125
  })
end

