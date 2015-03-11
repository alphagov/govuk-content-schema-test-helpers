require 'spec_helper'

describe GovukContentSchemaTestHelpers::Util do
  let(:subject) { GovukContentSchemaTestHelpers::Util }

  before do
    GovukContentSchemaTestHelpers.configuration.project_root = '/an/absolute/path'
    GovukContentSchemaTestHelpers.configuration.schema_type = 'a-type'
  end

  after do
    GovukContentSchemaTestHelpers.configuration.project_root = nil
    GovukContentSchemaTestHelpers.configuration.schema_type = nil
  end

  describe '#govuk_content_schemas_path' do
    it 'returns an absolute path, using the default relative path' do
      expect(subject.govuk_content_schemas_path).to eql('/an/absolute/path/../govuk-content-schemas')
    end

    describe 'when the environment variable is set' do
      it 'returns an absolute path, using the environment variable' do
        expect(ENV).to receive(:[]).with('GOVUK_CONTENT_SCHEMAS_PATH').and_return('../a-custom-path')
        expect(subject.govuk_content_schemas_path).to eql('/an/absolute/path/../a-custom-path')
      end
    end
  end
end
