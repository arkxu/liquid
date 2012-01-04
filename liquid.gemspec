# encoding: utf-8

Gem::Specification.new do |s|
  s.name        = "liquid"
  s.version     = "2.3.0"
  s.platform    = Gem::Platform::RUBY
  s.summary     = "A secure, non-evaling end user template engine with aesthetic markup."
<<<<<<< HEAD

  s.authors     = ["Ark Xu"]
  s.email       = ["ark.work@gmail.com"]
=======
  s.authors     = ["Tobias Luetke"]
  s.email       = ["tobi@leetsoft.com"]
>>>>>>> 1a1b4702d78022c113cacd2304c35aa9ffc6b5b7
  s.homepage    = "http://www.liquidmarkup.org"
  #s.description = "A secure, non-evaling end user template engine with aesthetic markup."

  s.required_rubygems_version = ">= 1.3.7"

<<<<<<< HEAD
  s.files             = Dir.glob("{lib}/**/*") + %w(MIT-LICENSE README.textile)

  s.extra_rdoc_files  = ["History.txt", "Manifest.txt", "README.textile"]

  s.require_path = ['lib']
  
  s.add_dependency('will_paginate', '>= 3.0.pre2')
  s.add_dependency('activesupport')
=======
  s.test_files  = Dir.glob("{test}/**/*")
  s.files       = Dir.glob("{lib}/**/*") + %w(MIT-LICENSE README.md)

  s.extra_rdoc_files  = ["History.md", "README.md"]

  s.require_path = "lib"
>>>>>>> 1a1b4702d78022c113cacd2304c35aa9ffc6b5b7
end
