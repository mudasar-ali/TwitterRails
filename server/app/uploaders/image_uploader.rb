class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
  process convert: 'png'
  # process tags: ['post_picture']
  # version :standard do
  #   process resize_to_fit: [300, 300]
  # end
  version :thumbnail do
    resize_to_fit(100, 100)
  end
  def store_dir
    "uploads/myphotos"
  end
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
