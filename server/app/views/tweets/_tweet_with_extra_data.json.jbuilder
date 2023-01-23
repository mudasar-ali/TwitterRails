    json.id tweet.id
    json.caption tweet.caption
    json.like_count tweet.likes.count
    json.comment_count tweet.comments.count
    json.created_at tweet.created_at
    json.user do
      json.partial! 'users/user', user: tweet.user
    end
    json.comments do
      json.partial! 'comments/comment', collection: tweet.comments, as: :comment
    end
    json.likes tweet.likes do |like|
      json.user like.user_id
    end
