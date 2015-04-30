require 'bundler/setup'
Bundler.setup

require 'govuk-content-schema-test-helpers'

def fixture_path(fixture_name = 'govuk-content-schemas')
  File.join(File.dirname(__FILE__), 'fixtures', fixture_name)
end
