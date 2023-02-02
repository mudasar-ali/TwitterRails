class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  default_scope { order(created_at: :desc) }

  validates :text, presence: true
  validates :tweet_id, presence: true
  validates :user_id, presence: true
end
