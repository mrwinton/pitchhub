source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# For redundancy
gem 'sqlite3'
gem 'activerecord-postgresql-adapter'
gem 'ar-octopus'

# Authentication
gem 'devise'
gem 'devise-bootstrap-views'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Pitchhub gems
gem "multi_json", "~> 1.11.2"
gem "moped"
gem "mongoid", "~> 4.0.0"
gem 'bson_ext'
gem "mongoid-paperclip", :require => "mongoid_paperclip"
gem "mongoid-enum"
gem 'mongoid-embedded-errors', :git => 'https://github.com/mrwinton/mongoid-embedded-errors.git'
# gem 'mongoid_denormalize', :git => 'https://github.com/mrwinton/mongoid_denormalize.git'
gem 'kaminari'
gem 'shamir-secret-sharing', :git => 'https://github.com/lian/shamir-secret-sharing.git'

# gem 'delayed_job_mongoid'
gem 'active_link_to', '~> 1.0.3'
gem 'cancancan', '~> 1.10'

# https://github.com/mauriciozaffari/mongoid_search
# https://github.com/pokonski/public_activity
gem 'mongoid_search'
gem 'public_activity'

# https://github.com/alexreisner/geocoder
gem 'geocoder'

group :development do
  gem 'metric_fu'
  gem 'better_errors'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # RSpec (unit tests, some integration tests)
  gem 'rspec-rails'

  # Behavioural tests with Rails integration
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'selenium-webdriver'

  # Performance tests
  gem 'rails-perftest'
  gem 'ruby-prof'
  gem 'request-log-analyzer'

  # General helpers
  gem 'webmock', :require => false
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker'
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
  # (only supports truncation with MongoDB as of 4/5/15)
  gem 'database_cleaner'
end

