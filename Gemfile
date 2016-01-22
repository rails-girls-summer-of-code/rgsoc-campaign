source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '3.2.13'

gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'
gem 'slim'
gem 'simple_form'
gem 'country_select'
gem 'gravatar-ultimate'
gem 'hashr'
gem 'simple_statistics'

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

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
