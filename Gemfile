# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bcrypt', '~> 3.1.7'
gem 'importmap-rails'
gem 'pg'
gem 'puma'
gem 'rails', github: 'rails/rails', branch: 'main'
gem 'redis'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'super_awesome_print'
end

group :development do
  # gem 'authentication-zero'
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'rackup'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
