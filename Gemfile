source 'https://rubygems.org'

ruby "2.5.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0'

gem 'dotenv-rails', '~> 2.7', '>= 2.7.5'
gem 'noko'
gem 'google_drive'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'delayed_job_active_record'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'holidays'

gem 'json', '~> 1.8.6'

group :production do
  gem 'pg', '~> 0.20.0'
  gem 'rails_12factor'
end

group :development do
  gem 'pry-byebug', platform: [:ruby_20], require: false
  gem "byebug"
  gem 'pg', '~> 0.20.0'
  gem 'spring'
end

group :test do
  gem 'rspec-rails'
  gem 'email_spec'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'coveralls', require: false
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
