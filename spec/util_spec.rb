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
      expect(ENV).to receive(:[]).with('GOVUK_CONTENT_SCHEMAS_PATH').and_return(nil)
      expect(subject.govuk_content_schemas_path).to eql('/an/absolute/govuk-content-schemas')
    end

    describe 'when the environment variable is set' do
      it 'returns an absolute path, using the environment variable' do
        expect(ENV).to receive(:[]).with('GOVUK_CONTENT_SCHEMAS_PATH').and_return('../a-custom-path')
        expect(subject.govuk_content_schemas_path).to eql('/an/absolute/a-custom-path')
      end
    end

    describe 'when the environment variable is set to an absolute path' do
      it 'returns an absolute path, using the environment variable' do
        expect(ENV).to receive(:[]).with('GOVUK_CONTENT_SCHEMAS_PATH').and_return('/a/custom/absolute/path/')
        expect(subject.govuk_content_schemas_path).to eql('/a/custom/absolute/path')
      end
    end
  end

  describe '#formats' do
    before do
      GovukContentSchemaTestHelpers.configuration.project_root = File.join(File.dirname(__FILE__), '..')
    end

    it 'returns the list of formats from govuk-content-schemas' do
      expect(subject.formats).to include('case_study', 'finder')
    end
  end
end
