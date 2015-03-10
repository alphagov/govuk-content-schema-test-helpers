module GovukContentSchemaTestHelpers
  class Validator
    def self.govuk_content_schemas_path
      ENV['GOVUK_CONTENT_SCHEMAS_PATH'] || '../govuk-content-schemas'
    end

    def self.schema_path(schema_name)
      project_root = GovukContentSchemaTestHelpers.configuration.project_root
      schema_type = GovukContentSchemaTestHelpers.configuration.schema_type
      File.join(project_root, self.govuk_content_schemas_path, "/formats/#{schema_name}/#{schema_type}/schema.json").to_s
    end
  end
end
