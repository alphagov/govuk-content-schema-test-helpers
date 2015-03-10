module GovukContentSchemaTestHelpers
  class Validator
    def self.govuk_content_schemas_path
      ENV['GOVUK_CONTENT_SCHEMAS_PATH'] || '../govuk-content-schemas'
    end
  end
end
