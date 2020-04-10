# frozen_string_literal: true

source 'https://rubygems.org'

gem 'puma'
gem 'rack'
gem 'roda'
gem 'sequel'
gem 'dotenv'
gem 'rake'
gem 'zeitwerk'
gem 'dry-schema'
gem 'pg'
gem 'sequel_pg'

# If you want to generate a JSON with routes' metadata
# See usage on https://github.com/jeremyevans/roda-route_list
gem 'roda-route_list'

# If you want to automatically parse the request body
# See usage on https://github.com/3scale/roda-parse-request
# gem 'roda-parse-request'

group :development, :test do
  gem 'rubycritic', require: false
  gem 'yard'
  gem 'rerun'
  gem 'awesome_print'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'pry'
end

group :test do
  gem 'simplecov', require: false
  gem 'rspec'
end
