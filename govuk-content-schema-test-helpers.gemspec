# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'govuk-content-schema-test-helpers/version'

Gem::Specification.new do |s|
  s.name        = 'govuk-content-schema-test-helpers'
  s.version     = GovukContentSchemaTestHelpers::VERSION
  s.date        = '2015-03-10'
  s.summary     = "Test helpers for working with GOV.UK content schemas"
  s.description = "This app provides test helpers for working with [alphagov/govuk-content-schemas](https://github.com/alphagov/govuk-content-schemas)"
  s.authors     = ["Jamie Cobbett", "David Heath"]
  s.email       = ['jamie.cobbett@digital.cabinet-office.gov.uk', 'david.heath@digital.cabinet-office.gov.uk']
  s.files       = ["lib/govuk-content-schema-test-helpers.rb"]
  s.homepage    = 'https://github.com/alphagov/govuk-content-schema-test-helpers'
  s.license     = 'MIT'
end
