source 'https://rubygems.org'

# Rails itself
gem 'rails', '3.2.13'

# Our HTTP server
gem 'unicorn'

# Dropbox api
gem 'dropbox-sdk'

# User encryption
gem 'devise'

# Make rails console db request more legible
gem 'hirb'

# File uploading to S3
gem 'carrierwave'

# File processing, resizing etc.
gem 'mini_magick'

# jQuery for Rails
gem 'jquery-rails'

# For sorting portfolio images
gem 'acts_as_list'

group :development, :test do
  gem 'better_errors'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'fog'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

