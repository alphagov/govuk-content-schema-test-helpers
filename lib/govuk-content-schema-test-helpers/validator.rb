require 'json-schema'

module GovukContentSchemaTestHelpers
  class Validator
    # schema_name should be a string, such as 'finder'
    # document should be a JSON string of the document to validate
    def initialize(schema_name, document)
      Util.check_govuk_content_schemas_path!

      @schema_name = schema_name
      @document = document
    end

    def valid?
      errors.empty?
    end

    def errors
      unless File.exists?(schema_path)
        raise ImproperlyConfiguredError, "Schema file not found at: #{schema_path}"
      end

      @errors ||= JSON::Validator.fully_validate(schema_path, @document)
    end

  private
    def schema_path
      File.join(
        Util.govuk_content_schemas_path,
        "dist/formats",
        @schema_name,
        GovukContentSchemaTestHelpers.configuration.schema_type,
        "schema.json"
      )
    end
  end
end
