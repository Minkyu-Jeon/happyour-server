class CkeditorPictureUploader < S3Uploader
  include Ckeditor::Backend::CarrierWave

  def store_dir
    "uploads/ckeditor/pictures/#{model.id}"
  end

  process :extract_dimensions

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [118, 100]
  end

  version :content do
    process resize_to_limit: [800, 800]
  end

  def extension_white_list
    Ckeditor.image_file_types
  end
end
