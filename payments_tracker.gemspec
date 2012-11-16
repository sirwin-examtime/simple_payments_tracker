$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "payments_tracker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payments_tracker"
  s.version     = PaymentsTracker::VERSION
  s.authors     = 'Simon Irwin'
  s.email       = 'simon.irwin@examtime.com'
  s.homepage    = "https://github.com/ExamTime/payments_tracker"
  s.summary     = "Summary of PaymentsTracker."
  s.description = "Description of PaymentsTracker."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
end
