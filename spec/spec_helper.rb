require 'bundler/setup'
Bundler.setup

require 'govuk-content-schema-test-helpers'

def fixture_path
  File.join(File.dirname(__FILE__), 'fixtures', 'govuk-content-schemas')
end
