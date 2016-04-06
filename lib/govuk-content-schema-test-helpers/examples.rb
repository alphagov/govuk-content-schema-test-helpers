module GovukContentSchemaTestHelpers
  class Examples
    def initialize
      Util.check_govuk_content_schemas_path!
    end

    def get(format, example_name)
      path = example_path(format, example_name)
      check_example_file_exists!(path)
      File.read(path)
    end

    def get_all_for_format(schema_name)
      glob_path = example_path(schema_name, '*')
      example_paths = Dir.glob(glob_path)

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

    def check_example_file_exists!(path)
      if !File.exists?(path)
        raise ImproperlyConfiguredError, "Example file not found: #{path}."
      end
    end

  private
    def example_path(format, example_name)
      schema_type = GovukContentSchemaTestHelpers.configuration.schema_type
      File.join(Util.govuk_content_schemas_path, "/formats/#{format}/#{schema_type}/examples/#{example_name}.json").to_s
    end
  end
end
