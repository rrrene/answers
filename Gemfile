source 'https://rubygems.org'

ruby '1.9.3'
gem 'nokogiri', '1.4.7'
gem 'rails', '3.2.17'
gem 'pg'
gem 'thin'
gem 'foreman'

gem 'newrelic_rpm', group: [:production, :staging, :development]
gem 'annotate', '~>2.4.1.beta'
gem 'progressbar'
gem 'facets', require: false
gem 'jquery-ui-rails'
gem 'jquery-rails', '~> 2.3.0'

gem 'meta-tags', require: 'meta_tags'

gem 'delayed_job_active_record'
gem 'memcachier'
gem 'dalli'
gem 'kgio'

gem 'activeadmin', '~> 0.5.1'
gem 'devise', '~> 2.0'
gem 'cancan'

gem 'tanker'
gem 'text'
gem 'httparty'
gem 'json'
gem 'indextank'

gem 'bluecloth'
gem 'kramdown'
gem 'friendly_id', '~> 4.0'
gem 'gon'
gem 'paperclip', '~> 3.0'
gem 'aws-sdk', '~> 1.3.4'

group :assets do
  gem 'sass-rails', '~> 3.2.5'
  gem 'bourbon', '~> 3.2.3'
  gem "meta_search", '>= 1.1.0.pre'
  gem 'uglifier', '>= 1.0.3'
  gem 'less-rails-bootstrap'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-fsevent'
end

group :test, :development do
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'memcached'
  gem 'pry-nav'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda'
  gem 'simplecov', '~> 0.7.1', require: false
  gem 'spork-rails'
  gem 'vcr'
  gem 'webmock'
end
