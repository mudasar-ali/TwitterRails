json.follow_data  @users do |user|
  json.partial! 'users/user', user: user
end
