source 'https://rubygems.org'

ruby '2.5.0'

gem 'rails', '~> 4.2'

gem 'stripe'
gem 'slim'
gem 'simple_form'
gem 'country_select'
gem 'hashr'
gem 'simple_statistics'
gem 'rollbar'
gem 'puma'

# for attr_accessible
# TODO: This gem won't be updated for Rails 5, so any usage of attr_accessible must be updated before upgrading
gem 'protected_attributes'

group :development do
  gem 'quiet_assets'
end

group :test do
  gem 'capybara'
  gem 'rake' # for Travis <3
end

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3'
end

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

gem 'jquery-rails'
