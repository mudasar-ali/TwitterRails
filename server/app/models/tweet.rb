class Tweet < ApplicationRecord

  mount_uploader :pictures, ImageUploader
  searchkick text_middle: [:caption]

  after_commit :reindex_tweet, on: [:create]

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  default_scope { order(created_at: :desc) }

  validates :caption, presence: true

  def reindex_tweet
    self.reindex
  end
end
