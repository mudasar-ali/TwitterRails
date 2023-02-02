 json.user do
    json.partial! 'users/user', user: @user
    json.followings @user.followings do |user|
      json.id user.id
    end
    json.followers @user.followers do |user|
      json.id user.id
    end
  end
