require 'json-schema'

module GovukContentSchemaTestHelpers
  class Validator
    # @param schema - the format (like `topic`). Use `format.links` for the
    def initialize(schema_name, variant, document)
      Util.check_govuk_content_schemas_path!

      @schema_name = schema_name
      @variant = variant
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
        "dist",
        "formats",
        @schema_name,
        GovukContentSchemaTestHelpers.configuration.schema_type,
        "#{@variant}.json"
      )
    end
  end
end
