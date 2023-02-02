    json.id tweet.id
    json.caption tweet.caption
    json.pictures tweet.pictures.url
    json.created_at tweet.created_at
    json.user do
      json.partial! 'users/user', user: tweet.user
      json.followers tweet.user.followers do |user|
        json.id tweet.user.id
        json.user user.id
      end
       json.followings tweet.user.followings do |user|
        json.user user.id
      end
    end
    json.comments do
      json.partial! 'comments/comment', collection: tweet.comments, as: :comment
    end
    json.likes do
      json.partial! "likes/like", collection: tweet.likes, as: :like
    end
