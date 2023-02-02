json.tweet do
  json.id @tweet.id
  json.caption @tweet.caption
  json.created_at @tweet.created_at
  json.user do
      json.partial! 'users/user', user: @tweet.user
  end

end
