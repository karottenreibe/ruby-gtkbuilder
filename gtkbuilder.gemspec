# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |s|
  s.name        = "gtkbuilder"
  s.version     = "0.3"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fabian Streitel"]
  s.email       = ["github@rottenrei.be"]
  s.homepage    = "http://github.com/karottenreibe/ruby-gtkbuilder"
  s.summary     = "Easy way to :reate simple Gtk GUIs"
  s.description = "Builder::Gtk let's you build Gtk windows using a simple DSL"

  s.add_dependency("gtk2")

  s.files         = `git ls-files`.split("\n")
  s.require_path = 'lib'
end

