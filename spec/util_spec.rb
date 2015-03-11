require 'spec_helper'

describe GovukContentSchemaTestHelpers::Util do
  let(:subject) { GovukContentSchemaTestHelpers::Util }

  describe '#govuk_content_schemas_path' do
    it 'returns the hardcoded path by default' do
      expect(subject.govuk_content_schemas_path).to eql('../govuk-content-schemas')
    end

    it 'returns the environment variable if set' do
      expect(ENV).to receive(:[]).with('GOVUK_CONTENT_SCHEMAS_PATH').and_return('../a-custom-path')
      expect(subject.govuk_content_schemas_path).to eql('../a-custom-path')
    end
  end
end
