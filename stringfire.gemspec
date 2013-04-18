# -*- coding: utf-8; mode: ruby  -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stringfire/version'

Gem::Specification.new do |gem|
  gem.name          = "stringfire"
  gem.version       = Stringfire::VERSION
  gem.authors       = ["Conan Dalton"]
  gem.email         = ["conan@conandalton.net"]
  gem.description   = %q{Strip the first token off a string, pass remainder of string as arg to function identified by first token}
  gem.summary       = "Useful where you want user-supplied executable expressions embedded in your data (in a CMS for example), but for obvious reasons you're not going to let them write ruby code"
  gem.homepage      = "https://github.com/conanite/stringfire"

  gem.add_development_dependency 'rspec', '~> 2.9'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
