module GovukContentSchemaTestHelpers
  module TestUnit
    def assert_valid_against_schema(content_item_hash, format)
      validator = GovukContentSchemaTestHelpers::Validator.new(format, "schema", content_item_hash.to_json)
      assert validator.valid?, "JSON not valid against #{format} schema: #{validator.errors.to_s}"
    end

    def assert_valid_against_links_schema(content_item_hash, format)
      validator = GovukContentSchemaTestHelpers::Validator.new(format, "links", content_item_hash.to_json)
      assert validator.valid?, "JSON not valid against #{format} schema: #{validator.errors.to_s}"
    end
  end
end
