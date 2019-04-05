# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'project-generator/version.rb'

Gem::Specification.new do |spec|
  spec.name          = "project-generator"
  spec.version       = ProjectGenerator::VERSION
  spec.authors       = ["Katie Hoffman"]
  spec.email         = ["ktahoffman@gmail.com"]
  spec.summary       = %q{A project generator}
  spec.description   = %q{Generates projects based on templates}
  spec.homepage      = "https://www.github.com/kthffmn"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "daemons", ["= 1.1.0"]
  spec.add_runtime_dependency "reposit"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
