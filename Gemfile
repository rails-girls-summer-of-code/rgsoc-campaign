source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '~> 4.2'

gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'
gem 'slim'
gem 'simple_form'
gem 'country_select'
gem 'gravatar-ultimate'
gem 'hashr'
gem 'simple_statistics'
gem 'rollbar', '~> 2.7.1'

# for attr_accessible
# TODO: This gem won't be updated for Rails 5, so any usage of attr_accessible must be updated before upgrading
gem 'protected_attributes'

group :development do
  gem 'quiet_assets'
  gem 'thin'
end

group :test do
  gem 'capybara'
  gem 'rake' # for Travis <3
end

group :production do
  gem 'pg'
  gem 'unicorn'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3'
end

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

gem 'jquery-rails'

# Needs to be available on Hoerku for running `rails console`
# TODO: Remove me after upgrading to Rails 4
gem 'test-unit'
