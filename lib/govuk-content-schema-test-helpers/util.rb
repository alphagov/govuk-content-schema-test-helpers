module GovukContentSchemaTestHelpers
  module Util
    def self.govuk_content_schemas_path
      relative_path = ENV['GOVUK_CONTENT_SCHEMAS_PATH'] || '../govuk-content-schemas'
      project_root = GovukContentSchemaTestHelpers.configuration.project_root
      File.absolute_path(relative_path, project_root)
    end
  end
end
