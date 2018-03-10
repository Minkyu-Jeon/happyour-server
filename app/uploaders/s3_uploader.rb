class S3Uploader < ApplicationUploader
  include CarrierWave::MiniMagick
  storage :fog
end
