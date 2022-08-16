lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ebay/version'

Gem::Specification.new do |s|
  s.name = 'ebay-api'
  s.version = Ebay::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.0.0'
  s.license = 'MIT'

  s.authors = ['Spocket Team']
  s.homepage = 'https://github.com/spocket-co/ebay-api-ruby'
  s.summary = 'Ruby client library for the ebay API'
  s.description = s.summary

  s.require_paths = ['lib']
  s.files = Dir['README.md', 'lib/**/*', 'ebay-api.gemspec']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'

  s.add_dependency 'faraday', '~> 1.0'
  s.add_dependency 'faraday_middleware', '~> 1.0'
  s.add_dependency 'hashie', '~> 3.4'
  s.add_dependency 'jwt', '~> 2.1.0'
end
