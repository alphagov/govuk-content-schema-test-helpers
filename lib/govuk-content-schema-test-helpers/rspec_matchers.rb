module GovukContentSchemaTestHelpers
  module RSpecMatchers
    RSpec::Matchers.define :be_valid_against_schema do |schema_name|
      match do |actual|
        validator = Validator.new(schema_name, actual)
        validator.valid?
      end

      # Required for a helpful message with RSpec 3
      description do |actual|
        validator = Validator.new(schema_name, actual)
        "to be valid against '#{schema_name}' schema. Errors: #{validator.errors}"
      end

      # Required for a helpful message with RSpec 2
      failure_message_for_should do |actual|
        validator = Validator.new(schema_name, actual)
        "to be valid against '#{schema_name}' schema. Errors: #{validator.errors}"
      end
    end
  end
end
