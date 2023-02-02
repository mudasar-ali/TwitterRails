json.follow_data  @users do |user|
  json.partial! 'users/user', user: user
  json.followings user.followings do |user|
    json.id @user.id
  end
  json.followers user.followers do |u|
    json.id user.id
    json.user u.id
  end
end
