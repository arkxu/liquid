# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY

  s.name        = "liquid"
  s.version     = '2.2.2'
  s.summary     = "A secure, non-evaling end user template engine with aesthetic markup."

  s.authors     = ["Ark Xu"]
  s.email       = ["ark.work@gmail.com"]
  s.homepage    = "http://www.liquidmarkup.org"

  s.description = "A secure, non-evaling end user template engine with aesthetic markup."

  s.required_rubygems_version = ">= 1.3.7"

  s.files             = Dir.glob("{lib}/**/*") + %w(MIT-LICENSE README.textile)

  s.extra_rdoc_files  = ["History.txt", "Manifest.txt", "README.textile"]

  s.require_path = ['lib']
  
  s.add_dependency('will_paginate')
  s.add_dependency('activesupport')
end
