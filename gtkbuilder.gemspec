# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |s|
  s.name        = "gtkbuilder"
  s.version     = "0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fabian Streitel"]
  s.email       = ["github@rottenrei.be"]
  s.homepage    = "http://github.com/karottenreibe/ruby-gtkbuilder"
  s.summary     = "Easy way to generate simple Gtk GUIs"
  s.description = "Builder::Gtk let's you build Gtk windows using a simple DSL"

  s.required_rubygems_version = ">= 1.3.6"

  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
end

