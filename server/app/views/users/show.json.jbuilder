json.user do
  json.partial! "users/user", user: @user
  json.followings @user.followings do |user|
    json.id user.id
  end
  json.followers @user.followers do |user|
    json.following_id @user.id
    json.user user.id
  end
  json.posts do
      json.partial! 'tweets/tweet',collection:  @user.tweets, as: :tweet
  end
end
