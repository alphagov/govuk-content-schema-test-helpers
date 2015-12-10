require 'spec_helper'
require 'govuk-content-schema-test-helpers/rspec_matchers'

describe GovukContentSchemaTestHelpers::RSpecMatchers do
  include GovukContentSchemaTestHelpers::RSpecMatchers

  before do
    ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = fixture_path

    GovukContentSchemaTestHelpers.configure do |c|
      c.schema_type = 'publisher'
    end
  end

  describe "#be_valid_against_schema" do
    it "correctly tests valid schemas" do
      expect(
        format: "minidisc"
      ).to be_valid_against_schema('minidisc')
    end

    it "fails for invalid schemas" do
      expect(
        not_format: "not minidisc"
      ).to_not be_valid_against_schema('minidisc')
    end
  end

  describe "#be_valid_against_links_schema" do
    it "correctly tests valid links" do
      expect(
        topics: ["topics"]
      ).to be_valid_against_links_schema('minidisc')
    end

    it "fails for invalid schemas" do
      expect(
        not_topics: ["topics"]
      ).to_not be_valid_against_links_schema('minidisc')
    end
  end
end
