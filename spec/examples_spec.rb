require 'spec_helper'

describe GovukContentSchemaTestHelpers::Examples do
  let(:subject) { GovukContentSchemaTestHelpers::Examples }

  describe '#initialize' do
    describe 'when the govuk-content-schemas directory does not exist' do
      before do
        GovukContentSchemaTestHelpers.configuration.project_root = '/non-existent-path'
        GovukContentSchemaTestHelpers.configuration.schema_type = 'frontend'
      end

      after do
        GovukContentSchemaTestHelpers.configuration.project_root = nil
        GovukContentSchemaTestHelpers.configuration.schema_type = nil
      end

      it 'raises an error' do
        expect { subject.new }.to raise_error(GovukContentSchemaTestHelpers::ImproperlyConfiguredError, /govuk-content-schemas cannot be found/)
      end
    end
  end

  describe '#get' do
    before do
      GovukContentSchemaTestHelpers.configuration.project_root = File.join(File.dirname(__FILE__), '..')
      GovukContentSchemaTestHelpers.configuration.schema_type = 'frontend'
    end

    after do
      GovukContentSchemaTestHelpers.configuration.project_root = nil
      GovukContentSchemaTestHelpers.configuration.schema_type = nil
    end

    describe 'when the example does exist' do
      it 'loads and parses the example file from govuk-content-schemas' do
        example = subject.new.get('finder', 'contacts')
        parsed_example = JSON.parse(example)
        expect(parsed_example["base_path"]).to eql("/government/organisations/hm-cheese-biscuits/contact")
      end
    end

    describe 'when the example does not exist' do
      it 'loads and parses the example file from govuk-content-schemas' do
        expect { subject.new.get('made-up', 'or-a-typo') }.to raise_error(GovukContentSchemaTestHelpers::ImproperlyConfiguredError, /Example file not found/)
      end
    end
  end
end
