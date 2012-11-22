# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_payments_tracker/version'

Gem::Specification.new do |gem|
  gem.name          = "simple_payments_tracker"
  gem.version       = SimplePaymentsTracker::VERSION
  gem.authors       = ["Simon Irwin"]
  gem.email         = ["simon_irwin@yahoo.co.uk"]
  gem.summary       = "Basic tracking of payment items."
  gem.description   = "This Gem implements basic payment items and installments"
  gem.homepage      = "https://github.com/sirwin-examtime/simple_payments_tracker"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", "~> 3.2.8"

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "factory_girl_rails"
end
