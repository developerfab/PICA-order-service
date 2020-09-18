source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'activerecord-sqlserver-adapter', '~> 6.0.0.rc2'
gem 'tiny_tds'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 4.0.1'
end

group :test do
  gem 'shoulda-matchers', '~> 4.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
