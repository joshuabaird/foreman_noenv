require File.expand_path('../lib/foreman_noenv/version', __FILE__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'foreman_noenv'
  s.version     = ForemanNoenv::VERSION
  s.date        = Date.today.to_s
  s.authors     = ['Josh Baird']
  s.email       = ['joshbaird@gmail.com']
  s.homepage    = 'https://github.com/joshuabaird/foreman_noenv'
  s.summary     = 'Adds the ability to disable environment enforcement per host'
  # also update locale/gemspec.rb
  s.description = 'The foreman_noenv plugin allows a hosts Puppet agent to specify a local environment'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'deface'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
