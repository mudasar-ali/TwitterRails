json.tweets do
  json.partial! 'tweets/tweet', collection: @tweets, as: :tweet
end
