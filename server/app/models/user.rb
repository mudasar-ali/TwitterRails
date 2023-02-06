# frozen_string_literal: true
require_relative "../helpers/delete_objects"
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

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


  def delete_previous_picture(previous_img_url,new_img)
    if previous_img_url && !new_img.nil?
      obj= previous_img_url.split('/').last
      delete_objects_from_s3(obj)
    end
  end

  scope :search, -> (term) { where("username like :term OR name like :term", term: "%#{term}%") }

end
