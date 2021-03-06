lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require 'hovercat/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'hovercat'
  s.version     = Hovercat::VERSION.dup
  s.authors     = ['Leonardo Bernardelli', 'Clayton Pacheco', 'Rofolfo Burla', 'Sandro Mileno']
  s.email       = ['contact-hovercat@m4u.com.br']
  s.homepage    = 'https://github.com/Mobile4You/hovercat'
  s.summary     = 'RabbitMQ connection abstraction with a retry handle.'
  s.description = 'RabbitMQ connection abstraction with a retry handle'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'rubocop-checkstyle_formatter'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
  s.add_development_dependency 'ci_reporter_rspec'
  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency "fakefs"
  s.add_development_dependency "rake"
  s.add_development_dependency "foreman"
  s.add_development_dependency 'factory_bot'


  s.add_dependency 'bunny', '>= 2.5.1', '<= 2.6.0'
  s.add_dependency 'sidekiq'
  s.add_dependency 'thor'
  s.add_dependency 'sucker_punch', '~> 2.0'
end
