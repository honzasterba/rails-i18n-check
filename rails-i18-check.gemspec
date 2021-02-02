# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-i18n-check/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-i18n-check"
  spec.version       = RailsI18nCheck::VERSION
  spec.authors       = ["Jan Sterba"]
  spec.email         = ["info@jansterba.com"]

  spec.summary       = %q{A simple checker for missing translations in rails i18n config files.}
  spec.homepage      = "https://github.com/honzasterba/rails-i18n-check"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.14"
end
