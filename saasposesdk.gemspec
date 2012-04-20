Gem::Specification.new do |s|
  s.name        = 'saasposesdk'
  s.version     = '0.0.3'
  s.date        = '2012-04-13'
  s.summary     = "Saaspose.SDK for Ruby"
  s.description = "Saaspose.SDK for Ruby allows you to use Saaspose API in your Ruby applications"
  s.authors     = ["Saaspose"]
  s.email       = 'contact@saaspose.com'
  s.files       = Dir['lib/*.rb']
  s.homepage = 'http://www.saaspose.com'

  s.add_dependency 'rest-client', '~> 1.6'

  s.add_development_dependency 'vcr', '~> 2.0'
  s.add_development_dependency 'webmock', '~> 1.8'
  s.add_development_dependency 'rspec', '~> 2.9'
  s.add_development_dependency 'pry', '~> 0.9'
end
