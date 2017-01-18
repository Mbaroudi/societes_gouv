source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'

gem 'puma', '~> 3.0'

gem 'sqlite3'
gem 'redis', '~> 3.0'
gem 'redis-namespace'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'pry'
end

group :development do
  gem 'mina', ref: '343a7', git: 'https://github.com/mina-deploy/mina.git'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'brakeman', require: false
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rspec', require: false
  gem 'rails_best_practices'
end
