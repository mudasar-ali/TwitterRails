class Image < ApplicationRecord
  mount_uploader :pictures, ImageUploader
  belongs_to :tweet
end
