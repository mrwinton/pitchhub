source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# Authenticate using the Devise library, with views styled in bootsrap. Read more: https://github.com/plataformatec/devise
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

# Use JSON to support the MongoDB library
gem "multi_json", "~> 1.11.2"
# Use Mongoid as an ODM to interface with MongoDB instances
gem "mongoid", "~> 4.0.0"
# Use BSON to support the MongoDB library
gem 'bson_ext'

# Extend the Mongoid library, to use paperclip for file uploads
gem "mongoid-paperclip", :require => "mongoid_paperclip"
# Extend the Mongoid library, to support enums
gem "mongoid-enum"
# Extend the Mongoid library, to propagate errors in embedded documents up to the root document
gem 'mongoid-embedded-errors', :git => 'https://github.com/mrwinton/mongoid-embedded-errors.git'

# Use a pagination library
gem 'kaminari'
# Enchance UX, to infinite scroll paginated pages
gem 'jquery-infinite-pages'
# Extend Rails 'link_to' to also indicate when the link should be 'active'
gem 'active_link_to', '~> 1.0.3'

# Authorise with the cancancan library. Read more: https://github.com/CanCanCommunity/cancancan
gem 'cancancan', '~> 1.10'

# Track user activity
gem 'ahoy_matey'

# Deployment gems
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rbenv', github: "capistrano/rbenv"

group :development do
  # Use a better, more interactive, error interface
  gem 'better_errors'
end

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

