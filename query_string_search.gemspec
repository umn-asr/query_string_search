# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'query_string_search/version'

Gem::Specification.new do |spec|
  spec.name          = "query_string_search"
  spec.version       = QueryStringSearch::VERSION
  spec.authors       = ["Ian Whitney", "Debbie Gillespie", "Davin Lagerroos"]
  spec.email         = ["asrwebteam@umn.edu"]
  spec.summary       = %q{Provides a standard way to do searches using query strings in an API endpoint}
  spec.homepage      = "https://github.com/umn-asr/query_string_search"
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"
  spec.add_development_dependency "travis", "~> 1.7"
  spec.add_development_dependency "rubocop"
end
