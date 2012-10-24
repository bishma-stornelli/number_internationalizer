# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'number_internationalizer/version'

Gem::Specification.new do |gem|
  gem.name          = "number_internationalizer"
  gem.version       = NumberInternationalizer::VERSION
  gem.authors       = ["Bishma Stornelli"]
  gem.email         = ["bishma.stornelli@gmail.com"]
  gem.description   = %q{Internationalize numbers adding normalization, validation and modifying the number field to restor the value to its original if validation fails}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
