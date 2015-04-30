require 'spec_helper'

describe GovukContentSchemaTestHelpers::Examples do
  let(:subject) { GovukContentSchemaTestHelpers::Examples }
  let(:fixture_path) { File.join(File.dirname(__FILE__), 'fixtures', 'govuk-content-schemas') }

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

  context 'when govuk-content-schemas directory does exist' do
    around do |example|
      old_path = ENV['GOVUK_CONTENT_SCHEMAS_PATH']
      ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = fixture_path
      GovukContentSchemaTestHelpers.configuration.schema_type = 'frontend'

      example.call

      ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = old_path
      GovukContentSchemaTestHelpers.configuration.schema_type = nil
    end

    describe '#get' do
      describe 'when the example does exist' do
        it 'loads and parses the example file from govuk-content-schemas' do
          example = subject.new.get('minidisc', 'my_example')
          parsed_example = JSON.parse(example)
          expect(parsed_example["base_path"]).to eql("/my-minidisc-example")
        end
      end

      describe 'when the example does not exist' do
        it 'loads and parses the example file from govuk-content-schemas' do
          expect { subject.new.get('made-up', 'or-a-typo') }.to raise_error(GovukContentSchemaTestHelpers::ImproperlyConfiguredError, /Example file not found/)
        end
      end
    end

    describe '#get_all_for_format' do
      it 'returns all examples for the format in an array' do
        examples = subject.new.get_all_for_format('minidisc')
        expect(examples).to be_an(Array)
        expect(examples.size).to eq(1)
        examples.each do |example|
          parsed_example = JSON.parse(example)
          expect(parsed_example["format"]).to eql("minidisc")
        end
      end
    end

    describe '#get_all_for_formats' do
      it 'returns all examples for the formats in an array' do
        examples = subject.new.get_all_for_formats(['minidisc'])
        expect(examples).to be_an(Array)
        expect(examples.size).to eq(1)

        formats_returned = examples.map { |e| JSON.parse(e)['format'] }.uniq
        expect(formats_returned).to match_array(['minidisc'])
      end
    end
  end
end
