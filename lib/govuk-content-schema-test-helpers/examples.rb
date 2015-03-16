module GovukContentSchemaTestHelpers
  class Examples
    def initialize
      Util.check_govuk_content_schemas_path!
    end

    def get(schema_name, example_name)
      path = example_path(schema_name, example_name)
      check_example_file_exists!(path)
      File.read(path)
    end

    def check_example_file_exists!(path)
      if !File.exists?(path)
        raise ImproperlyConfiguredError, "Example file not found: #{path}."
      end
    end

  private
    def example_path(schema_name, example_name)
      schema_type = GovukContentSchemaTestHelpers.configuration.schema_type
      File.join(Util.govuk_content_schemas_path, "/formats/#{schema_name}/#{schema_type}/examples/#{example_name}.json").to_s
    end
  end
end
