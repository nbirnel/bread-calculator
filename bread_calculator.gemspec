require './lib/bread_calculator'

Gem::Specification.new do |s|
  s.name        = 'bread_calculator'
  s.version     = BreadCalculator::VERSION
  s.date        = '2014-03-14'
  s.required_ruby_version = '>=1.9.2'
  s.summary     = "calculate baker's percentages"
  s.description = "a gem and command-line wrapper to generate baker's
                   percentages from a bread recipe"
  s.authors     = ['Noah Birnel']
  s.email       = 'nbirnel@gmail.com'
  s.homepage    = 'http://github.com/nbirnel/bread-calculator'
  s.files       = ['README.md', 'bread_calculator.gemspec', 'lib/bread_calculator.rb', 'spec/bread_calculator_spec.rb', 'bin/bread-calc']
  s.has_rdoc    = true
  s.executables = ['bread-calc']
  s.license     = 'MIT'
end
