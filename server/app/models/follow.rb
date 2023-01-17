class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  validates :following_id, uniqueness: { scope: %i[follower_id following_id] }
end
