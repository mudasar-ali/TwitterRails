json.tweet do
  json.partial! 'tweets/tweet_with_extra_data', tweet: @tweet
end
