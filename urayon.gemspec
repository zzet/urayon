# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'urayon/version'

Gem::Specification.new do |spec|
  spec.name          = "urayon"
  spec.version       = Urayon::VERSION
  spec.authors       = ["Andrey Kumanyaev"]
  spec.email         = ["me@zzet.org"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "webmock", "~> 1.15.2"
  spec.add_development_dependency "wrong", "~> 0.7.0"
  spec.add_development_dependency "mocha", "~> 0.13.3"

  spec.add_runtime_dependency "eventmachine"
  spec.add_runtime_dependency "sidekiq"
end
