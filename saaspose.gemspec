# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "saaspose/version"

Gem::Specification.new do |s|
  s.name        = 'saaspose'
  s.version     = Saaspose::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     =  s.description = "Ruby bindings to Saaspose REST API"
  s.authors     = ["Peter Schröder"]
  s.email       = 'phoetmail@googlemail.com'
  s.homepage    = 'https://github.com/phoet/saaspose'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rest-client', '~> 1.6'
  s.add_dependency 'confiture',   '~> 0.1'

  s.add_development_dependency 'vcr', '~> 2.1'
  s.add_development_dependency 'webmock', '~> 1.8'
  s.add_development_dependency 'rspec', '~> 2.9'
  s.add_development_dependency 'pry', '~> 0.9'
end
