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
      :aws_access_key_id      => 'AKIAIH6EQNZCL2WIMWVQ', 
      :aws_secret_access_key  => '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', 
    } 
    config.fog_directory  = 'monograph-media' 
    config.fog_public     = false
  end
end

