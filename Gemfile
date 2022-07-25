# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3"

# Use postgres as database
gem "pg", "~> 1.3.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.6.4"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors", "~> 1.1.1"

# use grape as API framework
gem "grape", "~> 1.6.2"
gem "grape_on_rails_routes", "~> 0.3.2"

# ruby linter
gem "rubocop", "~> 1.32", require: false
gem "rubocop-performance", "~> 1.14.3", require: false
gem "rubocop-rails", "~> 2.15.2", require: false
gem "rubocop-faker", "~> 1.1.0", require: false
gem "rubocop-rspec", "~> 2.12.1", require: false

# json serializer accoording to json api standard, see more: https://jsonapi.org/
gem "jsonapi-serializer", "~> 2.2.0"

# OPTIMIZE: json serialization
gem "oj", "~> 3.13.11"

# memoize objects
gem "memoist", "~> 0.16.2"

# paginating objects
gem "kaminari", "~> 1.2.2"

group :development, :test do
  gem "pry-rails", "~> 0.3.9"
  gem "pry-theme", "~> 1.3.1"
  gem "awesome_print", "~> 1.9.2"
  gem "pry-byebug", "~> 3.9.0"

  gem "rspec-rails", "~> 6.0.0.rc1"
  gem "database_cleaner-active_record", "~> 2.0.1"
  gem "test-prof", "~> 1.0.7"
  gem "stackprof", ">= 0.2.9", require: false
  gem "ruby-prof", ">= 0.17.0", require: false
  gem "faker", "~> 2.21.0"
  gem "factory_bot_rails", "~> 6.2.0"
  gem "brakeman", "~> 5.2.3"
end

group :test do
  gem "fuubar", "~> 2.5.1"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
