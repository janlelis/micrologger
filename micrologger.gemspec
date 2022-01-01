# -*- encoding: utf-8 -*-

require File.expand_path('../lib/micrologger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "micrologger"
  gem.version       = MicroLogger::VERSION
  gem.summary       = 'A minimal logger.'
  gem.description   = 'A minimal logger based on MicroEvent.rb'
  gem.license       = "MIT"
  gem.authors       = ["Jan Lelis"]
  gem.email         = ["hi@ruby.consulting"]
  gem.homepage      = "https://github.com/janlelis/micrologger"

  gem.files         = Dir['{**/}{.*,*}'].select { |path| File.file?(path) }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.metadata      = { "rubygems_mfa_required" => "true" }

  gem.add_dependency 'microevent', '~> 1.0'
  gem.add_dependency 'paint', '>= 0.9', '< 3.0'
end
