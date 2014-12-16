# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_service_searching/version'

Gem::Specification.new do |spec|
  spec.name          = "api_service_searching"
  spec.version       = ApiServiceSearching::VERSION
  spec.authors       = ["Ian Whitney"]
  spec.email         = ["whit0694@umn.edu"]
  spec.summary       = %q{Provides a standard way to do searches using query strings in an API endpoint}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
