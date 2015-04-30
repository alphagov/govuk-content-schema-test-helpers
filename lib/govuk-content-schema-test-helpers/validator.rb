require 'json-schema'

module GovukContentSchemaTestHelpers
  class Validator
    # Return the first schema path that exists on the filesystem
    def self.schema_path(schema_name)
      paths = candidate_schema_paths(schema_name)
      paths.detect { |path| File.exists?(path) } ||
        raise(ImproperlyConfiguredError, "Schema file not found at any of: #{paths.join(', ')}.")
    end

    # schema_name should be a string, such as 'finder'
    # document should be a JSON string of the document to validate
    def initialize(schema_name, document)
      Util.check_govuk_content_schemas_path!
      @schema_path = GovukContentSchemaTestHelpers::Validator.schema_path(schema_name)
      @document = document
    end

    def valid?
      errors.empty?
    end

    def errors
      @errors ||= JSON::Validator.fully_validate(@schema_path, @document)
    end

  private
    def self.construct_schema_path(prefix, schema_name)
      File.join(
        Util.govuk_content_schemas_path,
        prefix,
        schema_name,
        GovukContentSchemaTestHelpers.configuration.schema_type,
        "schema.json"
      )
    end

    def self.candidate_schema_paths(schema_name)
      ["dist/formats", "formats"].map { |prefix| construct_schema_path(prefix, schema_name) }
    end
  end
end
