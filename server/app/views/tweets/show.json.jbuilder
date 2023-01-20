json.tweet do
  json.partial! 'tweets/tweet', tweet: @tweet
  json.user do
    json.partial! "users/user", user: @tweet.user
  end
end
