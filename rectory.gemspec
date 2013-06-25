# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rectory/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kyle Truscott"]
  gem.email         = ["keighl@keighl.com"]
  gem.description   = %q{Test expected HTTP repsonse codes/locations.}
  gem.summary       = %q{Have a ton of redirects to test? Use this. Rectory will make a bunch of requests for you, and tell you what happened: status code, location, and whether it behaved as expected. Oh, and you can use a spreadsheet. }
  gem.homepage      = "https://github.com/keighl/rectory"

  gem.files         = [
    "lib/rectory.rb",
    "lib/rectory/verifier.rb",
    "lib/rectory/csv_outputter.rb",
    "lib/rectory/result.rb",
    "lib/rectory/expectation.rb",
    "lib/rectory/version.rb"
  ]

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rectory"
  gem.require_paths = ["lib"]
  gem.version       = Rectory::VERSION

  gem.add_runtime_dependency('celluloid')
  gem.add_development_dependency('rspec', '~> 2.4')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('webmock')
  gem.add_development_dependency('rb-fsevent')
  gem.add_development_dependency('yard')
  gem.add_development_dependency('redcarpet')
end
