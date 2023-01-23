json.tweet do
  json.partial! 'tweets/only_tweet_data', tweet: @tweet
end
