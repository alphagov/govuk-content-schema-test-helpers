require 'spec_helper'

describe GovukContentSchemaTestHelpers::Validator do
  let(:subject) { GovukContentSchemaTestHelpers::Validator }

  describe '#govuk_content_schemas_path' do
    it 'returns the hardcoded path by default' do
      expect(subject.govuk_content_schemas_path).to eql('../govuk-content-schemas')
    end

    it 'returns the environment variable if set' do
      expect(ENV).to receive(:[]).with('GOVUK_CONTENT_SCHEMAS_PATH').and_return('../a-custom-path')
      expect(subject.govuk_content_schemas_path).to eql('../a-custom-path')
    end
  end

  describe '#schema_path' do
    before do
      GovukContentSchemaTestHelpers.configuration.project_root = '/an/absolute/path'
      GovukContentSchemaTestHelpers.configuration.schema_type = 'a-type'
    end

    after do
      GovukContentSchemaTestHelpers.configuration.project_root = nil
      GovukContentSchemaTestHelpers.configuration.schema_type = nil
    end

    it 'returns the absolute path for the given format schema, based on configuration' do
      expect(subject.schema_path('minidisc')).to eql("/an/absolute/path/../govuk-content-schemas/formats/minidisc/a-type/schema.json")
    end
  end
end
