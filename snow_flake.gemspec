# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snow_flake/version'

Gem::Specification.new do |spec|
  spec.name          = 'snow_flake'
  spec.version       = SnowFlake::VERSION
  spec.authors       = %w(myamamoto88)
  spec.description   = %q{Snow Flake ID Generator}
  spec.summary       = %q{Snow Flake ID Generator}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = Dir[*%w(Gemfile lib/**/* snow_flake.gemspec spec/**/*)]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'timecop'
end
