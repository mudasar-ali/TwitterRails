# frozen_string_literal: true
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  searchkick text_middle: [:name, :username]

  after_commit :reindex_user, on: [:create]

  mount_uploader :prof_pic, ImageUploader

  has_many :following_users, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followings, through: :following_users
  has_many :follower_users, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_users
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :username, uniqueness: { case_sensitive: true }
  validates :username, :name, presence: true

  def reindex_user
    self.reindex
  end

end
