CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.secrets.fog.dig("aws_access_key_id"),
    aws_secret_access_key: Rails.application.secrets.fog.dig("aws_secret_access_key"),
    region:                Rails.application.secrets.fog.dig("region"),
  }
  config.fog_public = false
  config.fog_directory  = Rails.application.secrets.fog.dig("fog_directory")
end
