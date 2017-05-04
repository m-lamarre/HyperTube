source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'rails', '~> 5.0.2'

# Core
gem 'devise'
gem 'high_voltage'
gem 'inherited_resources', '~> 1.7'
gem 'paperclip', '~> 5.0.0'
gem 'pg'
gem 'pundit'
gem 'simple_form'
gem 'slim-rails'
gem 'will_paginate', '~> 3.1.0'

# APIs
gem 'httparty'

# Assests: Stylesheets
gem 'autoprefixer-rails'
gem 'foundation-rails'
gem 'sass-rails', '~> 5.0'

# Assests: Javascripts
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier'

# File management
gem 'carrierwave'
gem 'carrierwave-dropbox'
gem 'file_validators'
gem 'mini_magick'

# Omniauth
gem 'omniauth-facebook', '~> 4.0.0'
gem 'omniauth-google-oauth2', '~> 0.4.1'
gem 'omniauth-marvin', '~> 1.0.2'
gem 'omniauth-microsoft_v2_auth', path: './lib/omniauth-microsoft_v2_auth'

# Misc
gem 'faker'
gem 'figaro'
gem 'postmark-rails', '~> 0.15.0'
gem 'pry-rails'
gem 'puma', '~> 3.0'

# To test (TODO)
# gem 'tzinfo-data'

group :development do
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'letter_opener'
  gem 'listen'
  gem 'rails_layout'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'

  group :darwin do # OSX Only
    gem 'terminal-notifier-guard'
  end
end

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'dotenv-rails'
end
