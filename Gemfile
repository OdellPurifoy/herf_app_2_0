source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.5"

gem 'acts_as_favoritor'
gem 'bootstrap', '~> 5.2', '>= 5.2.3'
gem "bootstrap_form", "~> 5.1"
gem 'city-state', '~> 0.1.0'
gem 'devise'
gem 'faker', '~> 2.22'
gem 'file_validators', '~> 3.0'
gem 'friendly_id', '~> 5.4.0'
gem "font-awesome-sass", "~> 6.1.1"
gem 'jquery-rails'
gem 'kaminari'
gem 'pay', '~> 6.3', '>= 6.3.1'
gem 'pundit', '~> 2.3'
gem 'phonelib', '~> 0.7.4'
gem 'resque', '~> 2.4'
gem 'rubocop', require: false
gem 'simple_form'
gem 'stripe', '~> 8.1'
gem 'twilio-ruby', '~> 5.73', '>= 5.73.3'
gem 'validate_url', '~> 1.0', '>= 1.0.15'
# gem 'tod', '~> 3.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3"

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

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'shoulda-matchers', '~> 5.1'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

