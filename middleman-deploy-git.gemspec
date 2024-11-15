# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-deploy-git/pkg-info'

Gem::Specification.new do |spec|
  spec.name          = Middleman::Deploy::Git::PACKAGE
  spec.version       = Middleman::Deploy::Git::VERSION
  spec.authors       = ['Tom Vaughan', 'Karl Freeman', 'Tom Mullen']
  spec.email         = ['thomas.david.vaughan@gmail.com', 'karlfreeman@gmail.com', 'tm@okboring.com']
  spec.summary       = Middleman::Deploy::Git::TAGLINE
  spec.description   = Middleman::Deploy::Git::TAGLINE
  spec.homepage      = 'https://github.com/tom-mullen/middleman-deploy-git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'middleman-core', '>= 3.2'
  spec.add_dependency 'ptools'
  spec.add_dependency 'net-sftp'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'kramdown', '>= 0.14'
  spec.add_development_dependency 'rubocop', '~> 0.19'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'yard'
end
