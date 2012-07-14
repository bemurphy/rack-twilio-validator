# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib/", __FILE__)
require "rack/twilio-validator/version"

Gem::Specification.new do |s|
  s.name        = "rack-twilio-validator"
  s.version     = Rack::TwilioValidator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brendon Murphy"]
  s.email       = ["xternal1+github@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Rack Middleware for validating twilio request signatures}
  s.description = s.summary
  s.licenses    = ["MIT"]

  s.rubyforge_project = "rack-twilio-validator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rack'
  s.add_dependency 'twilio-ruby'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'rake'
end
