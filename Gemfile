source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
# Use postgresql as the database for Active Record
gem 'jquery-rails', '>= 4.4.0'
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
gem 'autoprefixer-rails', '>= 10.2.4.0'
# Добавление bootstrap
gem 'bootstrap-sass'

gem 'will_paginate', '>= 3.0.7'
gem 'bootstrap-will_paginate', '>= 0.0.10'
gem 'carrierwave'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
 gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

 group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry', '~> 0.13.1'
  gem 'pry-byebug'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  #!!!gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
gem 'slim-rails'
gem 'rails-controller-testing'
group :test,  :development do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara-webkit'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara', '>= 3.26'
end

group :test do
  gem 'webdrivers'
  gem 'json_spec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'dotenv-rails', require: 'dotenv/rails-now'
# gem 'dotenv-rails'
gem 'dotenv'
# gem 'dotenv-deployment', require: 'dotenv/deployment'

gem 'devise'
gem 'remotipart'
#gem 'simple_form'
gem "cocoon", "1.2.15"
#gem "nested_form"
gem "rails-ujs"
gem 'responders', '> 2.0' 
gem 'skim'
# gem 'gon'
# gem 'rabl-rails'
gem 'omniauth'
gem 'omniauth-facebook'
#gem 'cancancan'
gem 'pundit'
gem 'doorkeeper'
gem 'active_model_serializers'
gem 'oj'
gem 'oj_mimic_json'
# gem 'delayed_job_active_record'
# gem 'whenever'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
# gem 'sidetiq'
#gem "sidekiq-cron", "~> 1.1"
gem 'sidekiq-scheduler'
gem 'mysql2' #, '>=0.4.10'  #папка brew
gem 'thinking-sphinx'
gem 'therubyracer'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
end