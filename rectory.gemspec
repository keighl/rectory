# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rectory/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors     = ["Kyle Truscott"]
  gem.email       = ["keighl@keighl.com"]
  gem.description = %q{Quickly test HTTP redirects and status codes.}
  gem.summary     = %q{HHave a ton of HTTP redirects, and need to verify they're working? Use this. Give rectory a list of live HTTP expectations, and it'll tell you what happens: status code, location, and whether it behaved as expected (i.e pass/fail).}
  gem.homepage    = "https://github.com/keighl/rectory"
  gem.license     = 'MIT'

  gem.files         = [
    "lib/rectory.rb",
    "lib/rectory/request.rb",
    "lib/rectory/csv_outputter.rb",
    "lib/rectory/expectation.rb",
    "lib/rectory/version.rb"
  ]

  gem.executables   = %w{rectory}

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
  gem.add_development_dependency('rake')
end
