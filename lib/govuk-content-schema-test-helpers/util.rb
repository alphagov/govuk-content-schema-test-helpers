module GovukContentSchemaTestHelpers
  module Util
    def self.govuk_content_schemas_path
      relative_path = ENV['GOVUK_CONTENT_SCHEMAS_PATH'] || '../govuk-content-schemas'
      project_root = GovukContentSchemaTestHelpers.configuration.project_root
      File.absolute_path(relative_path, project_root)
    end

    def self.check_govuk_content_schemas_path!
      if !File.exists?(Util.govuk_content_schemas_path)
        message = "Dependency govuk-content-schemas cannot be found at: #{govuk_content_schemas_path}."
        message += " Clone it to that directory, or set GOVUK_CONTENT_SCHEMAS_PATH (see README.md for details)."
        raise ImproperlyConfiguredError, message
      end
    end
  end
end
