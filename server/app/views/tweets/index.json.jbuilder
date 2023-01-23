json.tweets do
  json.partial! 'tweets/tweet_with_extra_data', collection: @tweets, as: :tweet
end
