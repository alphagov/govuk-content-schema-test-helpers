require 'json-schema'

module GovukContentSchemaTestHelpers
  class ImproperlyConfiguredError < RuntimeError; end

  class Validator
    def self.schema_path(schema_name)
      schema_type = GovukContentSchemaTestHelpers.configuration.schema_type
      File.join(Util.govuk_content_schemas_path, "/formats/#{schema_name}/#{schema_type}/schema.json").to_s
    end

    # schema_name should be a string, such as 'finder'
    # document should be a JSON string of the document to validate
    def initialize(schema_name, document)
      @schema_path = GovukContentSchemaTestHelpers::Validator.schema_path(schema_name)

      govuk_content_schemas_path = Util.govuk_content_schemas_path
      if !Pathname(govuk_content_schemas_path).exist?
        message = "Dependency govuk-content-schemas cannot be found at: #{govuk_content_schemas_path}."
        message += " Clone it to that directory, or set GOVUK_CONTENT_SCHEMAS_PATH (see README.md for details)."
        raise ImproperlyConfiguredError, message
      elsif !File.exists?(@schema_path)
        raise ImproperlyConfiguredError, "Schema file not found: #{@schema_path}."
      end
      @document = document
    end

    def valid?
      errors.empty?
    end

    def errors
      @errors ||= JSON::Validator.fully_validate(@schema_path, @document)
    end
  end
end
