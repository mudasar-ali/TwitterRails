class Tweet < ApplicationRecord


  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :images

  default_scope { order(created_at: :desc) }

  validates :caption, presence: true
end
