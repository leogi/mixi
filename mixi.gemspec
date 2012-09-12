# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mixi/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["levannghia"]
  gem.email         = ["nghialv.bk@gmail.com"]
  gem.description   = %q{mixi api}
  gem.summary       = %q{mixi api}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mixi"
  gem.require_paths = ["lib"]
  gem.version       = Mixi::VERSION

  gem.add_development_dependency 'rspec'
end
