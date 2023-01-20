json.comments @comments do |comment|
  json.partial! "comments/comment", comment: comment
end
