class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :standard do
    process resize_to_fit: [300, 300]
    storage :fog
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
