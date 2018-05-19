CarrierWave.configure do |config|
  config.asset_host = Rails.application.secrets.carrierwave.dig("asset_host") if Rails.application.secrets.carrierwave.dig("asset_host")
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.secrets.fog.dig("aws_access_key_id"),
    aws_secret_access_key: Rails.application.secrets.fog.dig("aws_secret_access_key"),
    region:                Rails.application.secrets.fog.dig("region"),
    endpoint:              Rails.application.secrets.fog.dig("endpoint")
  }
  config.fog_public = true
  config.fog_directory  = Rails.application.secrets.fog.dig("fog_directory")
end
