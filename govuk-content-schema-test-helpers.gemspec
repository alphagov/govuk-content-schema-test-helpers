# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'govuk-content-schema-test-helpers/version'

Gem::Specification.new do |s|
  s.name        = 'govuk-content-schema-test-helpers'
  s.version     = GovukContentSchemaTestHelpers::VERSION
  s.summary     = "Test helpers for working with GOV.UK content schemas"
  s.description = "This app provides test helpers for working with [alphagov/govuk-content-schemas](https://github.com/alphagov/govuk-content-schemas)"
  s.authors     = ["Jamie Cobbett", "David Heath"]
  s.email       = ['jamie.cobbett@digital.cabinet-office.gov.uk', 'david.heath@digital.cabinet-office.gov.uk']
  s.files       = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.homepage    = 'https://github.com/alphagov/govuk-content-schema-test-helpers'
  s.license     = 'MIT'

  s.add_runtime_dependency 'json-schema', '~> 2.5.1'

  s.add_development_dependency 'gem_publisher', '1.5.0'
  s.add_development_dependency 'rake', '10.4.2'
  s.add_development_dependency 'rspec', '3.2.0'
  s.add_development_dependency 'pry-byebug'
end
