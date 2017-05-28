source 'https://rubygems.org'

gem 'rails', '5.0.1'
gem 'mysql2', '0.3.18'
gem 'puma', '3.7'

group :assets do
  gem 'sass-rails', '~> 5.0'  
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.2'
end

# For File Upload
gem 'carrierwave'

# For User Authentication
gem 'devise', '4.1.0'

gem 'active_model_serializers'

gem 'mina'
gem 'mina-puma', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
