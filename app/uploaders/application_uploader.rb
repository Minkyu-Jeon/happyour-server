class ApplicationUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    @__filename ||= "#{timestamp}.#{file.extension}" if original_filename.present?
  end

  def extension
    @file.extension
  end

protected
  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.current.to_i)
  end
end
