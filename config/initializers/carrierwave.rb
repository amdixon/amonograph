# for development environment
if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

# for production environment
if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    
    # amazon AWS storage information
    config.fog_credentials = { 
      :provider               => 'AWS', 
      :aws_access_key_id      => '', 
      :aws_secret_access_key  => '', 
    } 
    config.fog_directory  = 'monograph-media' 
    config.fog_public     = false
  end
end

