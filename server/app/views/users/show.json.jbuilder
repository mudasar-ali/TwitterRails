json.user do
  json.partial! 'user', user: @user
  json.posts @user.tweets do |tweet|
    json.partial! 'tweets/tweet', tweet: tweet
    json.comments tweet.comments do |comment|
      json.partial! 'comments/comment', comment: comment
    end
    json.likes tweet.likes do |like|
      json.user like.user_id
    end
  end
end
