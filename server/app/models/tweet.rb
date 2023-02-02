class Tweet < ApplicationRecord

  mount_uploader :pictures, ImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  default_scope { order(created_at: :desc) }

  validates :caption, presence: true
end
