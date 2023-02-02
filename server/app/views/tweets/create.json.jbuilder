json.tweet do
  json.partial! 'tweets/tweet', tweet: @tweet
end
