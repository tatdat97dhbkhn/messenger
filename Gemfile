source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# If you are using active_storage gem and you want to add simple validations for it,
# like presence or content_type you need to write a custom validation method.
gem 'active_storage_validations'

# Devise is a flexible authentication solution for Rails based on Warden
gem 'devise'

# Draper adds an object-oriented layer of presentation logic to your Rails application.
gem 'draper'

# Agnostic pagination in plain ruby: it works with any framework, ORM and DB type, with all kinds of collections,
# even pre-paginated, scopes, Arrays, JSON data... and just whatever you can count.
# Easy to use and customize, very fast and very light.
gem 'pagy'

# Faraday is an HTTP client library that provides a common interface over many adapters (such as Net::HTTP) and embraces the concept of Rack middleware when processing the request/response cycle.
gem 'faraday'

# Various middleware for Faraday
gem 'faraday_middleware'

# Simple, efficient background processing for Ruby.
gem 'sidekiq'

# counter_culture provides turbo-charged counter caches that are kept up-to-date not just on create and destroy,
# that support multiple levels of indirection through relationships,
# allow dynamic column names and that avoid deadlocks by updating in the after_commit callback.
gem 'counter_culture'

# The Cloudinary Ruby on Rails SDK allows you to quickly and easily integrate your application with Cloudinary.
# Effortlessly optimize, transform, upload and manage your cloud's assets.
gem 'cloudinary'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Use Pry as your rails console
  gem 'pry-rails'

  # Add a comment summarizing the current schema to the top or bottom of each of your ActiveRecord models...
  gem 'annotate'

  # help to kill N+1 queries and unused eager loading.
  gem 'bullet'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
