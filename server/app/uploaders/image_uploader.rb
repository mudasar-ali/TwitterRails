class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process convert: 'png'
  process tags: ['post_picture']
  version :standard do
    process resize_to_fill: [1080, 1080, :center]
  end
  version :thumbnail do
    resize_to_fit(100, 100)
  end
end
