# frozen_string_literal: true

source 'http://rubygems.org'

group :development, :test do
  gem 'activerecord'
  gem 'rspec'
  gem 'sqlite3'
end

group :development, :lint do
  gem 'racc', '~> 1.7' # for RuboCop, on Ruby 3.3
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
end

# Specify your gem's dependencies in validates_cpf_cnpj.gemspec
gemspec
