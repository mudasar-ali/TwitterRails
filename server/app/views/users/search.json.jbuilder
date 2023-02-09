json.user @users do |user|
  json.id user.id
  json.name user.name
  json.username user.username
  json.prof_pic user.prof_pic.standard.url
  json.followings user.followings do |u|
    json.id user.id
  end
  json.followers user.followers do |u|
    json.id user.id
    json.user u.id
  end
end
