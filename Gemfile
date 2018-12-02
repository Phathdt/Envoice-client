source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

## Base libs
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'

## Fronend
gem 'bootstrap-toggle-rails'
gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-sass', '~> 5.2.0'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'

## Authenicate
gem 'devise'
gem 'devise-async'
gem 'devise_invitable', '~> 1.7.0'

## authorization
gem 'pundit'
gem 'rolify'

## Nem core
gem 'nem-ruby'

## Helper gems
gem 'aasm'
gem 'active_storage_validations'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise-i18n'
gem 'figaro'
gem 'image_processing', '~> 1.2'
gem 'js-routes'
gem 'kaminari'
gem 'rails-i18n'
gem 'ransack'
gem 'sidekiq'
gem "cocoon"
gem 'active_model_serializers', '~> 0.10.7'
gem 'humanize',  :git => 'https://github.com/Phathdt/humanize.git'
gem 'pdfkit'
gem 'wkhtmltopdf-binary'
gem 'rest-client'

group :development, :test do
  gem 'byebug'
  gem 'pry-nav'
  gem 'pry-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-erd', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem "aws-sdk-s3", require: false
end
