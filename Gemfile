# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# Search
gem "ransack"

# Other
gem "dotenv-rails"
gem "pagy", "~> 8.2"
gem "the-free-dictionary", git: 'https://github.com/Suban05/the-free-dictionary'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem "ruby-lsp-rails"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
