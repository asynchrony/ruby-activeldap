# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "activeldap3"
  s.version = '1.2.3'
  s.platform = Gem::Platform::RUBY
  s.authors = ["Will Drewry", "Kouhei Sutou", "koutou", "Kenny Ortmann"]
  s.email = ['kenny.ortmann@gmail.com']
  s.homepage = "https://github.com/asynchrony/ruby-activeldap"
  s.summary = %q{working towards getting active ldap to work on rails 3}
  s.description = %q{working towards getting active ldap to work on rails 3}

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", "po"]
end