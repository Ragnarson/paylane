# -*- encoding: utf-8 -*-
require File.expand_path('../lib/paylane/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bartlomiej Kozal"]
  gem.email         = ["bkzl@me.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "paylane"
  gem.require_paths = ["lib"]
  gem.version       = PayLane::VERSION

  gem.add_dependency "savon"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "fakeweb"
end
