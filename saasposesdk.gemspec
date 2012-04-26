# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "saasposesdk/version"

Gem::Specification.new do |s|
  s.name        = 'saasposesdk'
  s.version     = Saasposesdk::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Saaspose.SDK for Ruby"
  s.description = "Saaspose.SDK for Ruby allows you to use Saaspose API in your Ruby applications"
  s.authors     = ["Saaspose", "Peter Schröder"]
  s.email       = 'contact@saaspose.com'
  s.homepage    = 'http://www.saaspose.com'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rest-client', '~> 1.6'

  s.add_development_dependency 'vcr', '~> 2.1'
  s.add_development_dependency 'webmock', '~> 1.8'
  s.add_development_dependency 'rspec', '~> 2.9'
  s.add_development_dependency 'pry', '~> 0.9'
end
