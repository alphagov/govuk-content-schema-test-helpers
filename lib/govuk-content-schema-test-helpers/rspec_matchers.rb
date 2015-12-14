module GovukContentSchemaTestHelpers
  module RSpecMatchers
    RSpec::Matchers.define :be_valid_against_schema do |schema_name|
      match do |actual|
        validator = Validator.new(schema_name, "schema", actual)
        validator.valid?
      end

      # `failure_message` is RSpec 3.0, `failure_message_for_should` also works
      # in 2.X, but deprecated in rspec 3.0.
      if respond_to?(:failure_message)
        failure_message do |actual|
          ValidationErrorMessage.new(schema_name, "schema", actual).message
        end
      else
        failure_message_for_should do |actual|
          ValidationErrorMessage.new(schema_name, "schema", actual).message
        end
      end
    end

    RSpec::Matchers.define :be_valid_against_links_schema do |schema_name|
      match do |actual|
        validator = Validator.new(schema_name, "links", actual)
        validator.valid?
      end

      # `failure_message` is RSpec 3.0, `failure_message_for_should` also works
      # in 2.X, but deprecated in rspec 3.0.
      if respond_to?(:failure_message)
        failure_message do |actual|
          ValidationErrorMessage.new(schema_name, "links", actual).message
        end
      else
        failure_message_for_should do |actual|
          ValidationErrorMessage.new(schema_name, "links", actual).message
        end
      end
    end
  end

  class ValidationErrorMessage
    attr_reader :schema_name, :type, :payload

    def initialize(schema_name, type, payload)
      @schema_name = schema_name
      @type = type
      @payload = payload
    end

    def message
<<-doc
expected the payload to be valid against the '#{schema_name}' schema:

#{formatted_payload}

Validation errors:
#{errors}
doc
    end

  private
    def errors
      validator = Validator.new(schema_name, type, payload)
      validator.errors.map { |message| "- " + humanized_error(message) }.join("\n")
    end

    def formatted_payload
      return payload if payload.is_a?(String)
      JSON.pretty_generate(payload)
    end

    def humanized_error(message)
      message.gsub("The property '#/'", "The item")
    end
  end
end
