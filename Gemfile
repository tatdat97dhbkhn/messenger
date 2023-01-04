# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main" [https://github.com/rails/rails]
gem 'rails', '~> 7.0.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record [https://github.com/ged/ruby-pg]
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production [https://github.com/redis/redis-rb]
gem 'redis', '~> 5.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem [https://github.com/tzinfo/tzinfo-data]
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb [https://github.com/Shopify/bootsnap]
gem 'bootsnap', require: false

# Use Sass to process CSS [https://github.com/sass/sassc-rails]
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

# If you are using active_storage gem and you want to add simple validations for it,
# like presence or content_type you need to write a custom validation method.
# [https://github.com/igorkasyanchuk/active_storage_validations]
gem 'active_storage_validations'

# Devise is a flexible authentication solution for Rails based on Warden [https://github.com/heartcombo/devise]
gem 'devise'

# Draper adds an object-oriented layer of presentation logic to your Rails application.
# [https://github.com/drapergem/draper]
gem 'draper'

# Agnostic pagination in plain ruby: it works with any framework, ORM and DB type, with all kinds of collections,
# even pre-paginated, scopes, Arrays, JSON data... and just whatever you can count.
# Easy to use and customize, very fast and very light. [https://github.com/ddnexus/pagy]
gem 'pagy'

# Faraday is an HTTP client library that provides a common interface over many adapters (such as Net::HTTP)
# and embraces the concept of Rack middleware when processing the request/response cycle.
# [https://github.com/lostisland/faraday]
gem 'faraday'

# Various middleware for Faraday [https://github.com/lostisland/faraday_middleware]
gem 'faraday_middleware'

# Simple, efficient background processing for Ruby. [https://github.com/mperham/sidekiq]
gem 'sidekiq'

# counter_culture provides turbo-charged counter caches that are kept up-to-date not just on create and destroy,
# that support multiple levels of indirection through relationships,
# allow dynamic column names and that avoid deadlocks by updating in the after_commit callback.
# [https://github.com/magnusvk/counter_culture]
gem 'counter_culture'

# The Cloudinary Ruby on Rails SDK allows you to quickly and easily integrate your application with Cloudinary.
# Effortlessly optimize, transform, upload and manage your cloud's assets.
# [https://github.com/cloudinary/cloudinary_gem]
gem 'cloudinary'

# This library allows you to quickly and easily use the Twilio SendGrid Web API v3 via Ruby.
# [https://github.com/sendgrid/sendgrid-ruby]
gem 'sendgrid-ruby'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # RuboCop is a Ruby code style checking and code formatting tool.
  # It aims to enforce the community-driven Ruby Style Guide. [https://github.com/rubocop/rubocop]
  gem 'rubocop'

  # Automatic Rails code style checking tool.
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  # [https://github.com/rubocop/rubocop-rails]
  gem 'rubocop-rails'

  # Performance optimization analysis for your projects, as an extension to RuboCop.
  # [https://github.com/rubocop/rubocop-performance]
  gem 'rubocop-performance', require: false

  # A RuboCop plugin for Rake. [https://github.com/rubocop/rubocop-rake]
  gem 'rubocop-rake', require: false

  # Database Cleaner is a set of gems containing strategies for cleaning your database in Ruby.
  # [https://github.com/DatabaseCleaner/database_cleaner]
  gem 'database_cleaner'

  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer
  # [https://github.com/thoughtbot/factory_bot_rails]
  gem 'factory_bot_rails'

  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  # [https://rubygems.org/gems/faker]
  gem 'faker'

  # rspec-rails brings the RSpec testing framework to Ruby on Rails as a drop-in alternative
  # to its default testing framework, Minitest. [https://github.com/rspec/rspec-rails]
  gem 'rspec-rails'

  # Shoulda helps you write more understandable, maintainable Rails-specific tests under Minitest and Test::Unit.
  # [https://github.com/thoughtbot/shoulda]
  gem 'shoulda'

  # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
  # [https://github.com/simplecov-ruby/simplecov]
  gem 'simplecov', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Use Pry as your rails console [https://github.com/pry/pry-rails]
  gem 'pry-rails'

  # Add a comment summarizing the current schema to the top or bottom of each of your ActiveRecord models...
  # [https://github.com/ctran/annotate_models]
  gem 'annotate'

  # help to kill N+1 queries and unused eager loading. [https://github.com/flyerhzm/bullet]
  gem 'bullet'

  # Brakeman is a static analysis tool which checks Ruby on Rails applications for security vulnerabilities.
  # [https://github.com/presidentbeef/brakeman]
  gem 'brakeman'

  # bundler-audit provides patch-level verification for Bundled apps. [https://github.com/rubysec/bundler-audit]
  gem 'bundler-audit'

  # RubyAudit checks your current version of Ruby and RubyGems against known security vulnerabilities (CVEs),
  # alerting you if you are using an insecure version.
  # It complements bundler-audit, providing complete coverage for your Ruby stack.
  # [https://github.com/civisanalytics/ruby_audit]
  gem 'ruby_audit'

  # Utility to install, configure, and extend Git hooks [https://github.com/sds/overcommit]
  gem 'overcommit'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]

  # Capybara helps you test web applications by simulating how a real user would interact with your app.
  # It is agnostic about the driver running your tests and comes with Rack::Test and Selenium support built in.
  # WebKit is supported through an external gem. [https://github.com/teamcapybara/capybara]
  gem 'capybara'

  # This gem provides Ruby bindings for Selenium and supports MRI >= 2.6
  # [https://github.com/SeleniumHQ/selenium/tree/trunk/rb]
  gem 'selenium-webdriver'

  # Run Selenium tests more easily with automatic installation and updates for all supported webdrivers.
  # [https://github.com/titusfortner/webdrivers]
  gem 'webdrivers'
end
