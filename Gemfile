# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip

gem "rails"
gem "sprockets-rails"
gem "pg"
gem "puma"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "autoprefixer-rails"
gem "jbuilder"
gem "bootsnap", require: false
gem "slim"
gem "slim-rails"
gem "dotenv-rails"
gem "httparty"
gem "amazing_print"
gem "table_print"
gem "avo"

group :development, :test do
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rescue"
  gem "pry-stack_explorer"
  gem "pry-rails"
  gem "ruby_jard"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-performance", require: false
end

group :development do
  gem "web-console"
  gem "standard"
  gem "annotate"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
