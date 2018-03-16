module GovukContentSchemaTestHelpers
  class Examples
    def initialize
      Util.check_govuk_content_schemas_path!
    end

    def get(format, example_name)
      path = example_path(format, example_name)
      legacy_path = legacy_example_path(format, example_name)
      file_that_exists = check_an_example_file_exists(path, legacy_path)
      File.read(file_that_exists)
    end

    def get_all_for_format(schema_name)
      glob_path = example_path(schema_name, '*')
      legacy_glob_path = legacy_example_path(schema_name, '*')

      example_paths = Dir.glob(glob_path)
      example_paths = Dir.glob(legacy_glob_path) unless example_paths.any?

      if example_paths.any?
        example_paths.map do |path|
          File.read(path)
        end
      else
        raise ImproperlyConfiguredError, "No examples found for schema: #{schema_name}"
      end
    end

    def get_all_for_formats(schema_names)
      schema_names.inject([]) do |memo, schema_name|
        memo + get_all_for_format(schema_name)
      end
    end

  private

    def check_an_example_file_exists(path, legacy_path)
      return path if File.exist?(path)
      return legacy_path if File.exist?(legacy_path)

      raise ImproperlyConfiguredError, "Example file not found, checked: #{path} and #{legacy_path}."
    end

    def legacy_example_path(format, example_name)
      schema_type = GovukContentSchemaTestHelpers.configuration.schema_type
      File.join(Util.govuk_content_schemas_path, "/formats/#{format}/#{schema_type}/examples/#{example_name}.json").to_s
    end

    def example_path(format, example_name)
      schema_type = GovukContentSchemaTestHelpers.configuration.schema_type
      File.join(Util.govuk_content_schemas_path, "/examples/#{format}/#{schema_type}/#{example_name}.json").to_s
    end
  end
end
