# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'echonest-ruby-api/version'

Gem::Specification.new do |gem|
  gem.name          = "echonest-ruby-api"
  gem.version       = Echonest::VERSION
  gem.authors       = ["Max Woolf"]
  gem.email         = ["max.woolf@boxuk.com"]
  gem.description   = "A simple ruby wrapper around the Echonest API"
  gem.summary       = "A gem to get hold of some echonest stuff!"
  gem.homepage      = "https://github.com/maxehmookau/echonest-ruby-api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('httparty')
  gem.add_dependency('multi_json')
  gem.add_development_dependency "rspec", "~> 2.6"
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9.1'
  gem.add_development_dependency 'mocha'
end
