json.user do
  json.id @user.id
  json.name @user.name
  json.username @user.username
  json.prof_pic @user.prof_pic.url
  json.posts @user.tweets do |tweet|
    json.partial! 'tweets/only_tweet_data', tweet: tweet
    json.likes tweet.likes do |like|
      json.user like.user_id
    end
  end
end
