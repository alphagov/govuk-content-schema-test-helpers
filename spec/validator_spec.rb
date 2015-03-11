require 'spec_helper'

describe GovukContentSchemaTestHelpers::Validator do
  let(:subject) { GovukContentSchemaTestHelpers::Validator }

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

  describe '#initialize' do
    describe 'when the govuk-content-schemas directory does not exist' do
      before do
        GovukContentSchemaTestHelpers.configuration.project_root = '/an/absolute/path'
        GovukContentSchemaTestHelpers.configuration.schema_type = 'a-type'

        allow(ENV).to receive(:[]).with('GOVUK_CONTENT_SCHEMAS_PATH').and_return('../a-non-existent-path')
      end

      after do
        GovukContentSchemaTestHelpers.configuration.project_root = nil
        GovukContentSchemaTestHelpers.configuration.schema_type = nil
      end

      it 'raises an error' do
        expect { subject.new('foo',  '{}') }.to raise_error(GovukContentSchemaTestHelpers::ImproperlyConfiguredError, /govuk-content-schemas cannot be found/)
      end
    end

    describe 'when the schema file does not exist' do
      before do
        GovukContentSchemaTestHelpers.configuration.project_root = File.join(__FILE__, '..')
        GovukContentSchemaTestHelpers.configuration.schema_type = 'a-type'
      end

      after do
        GovukContentSchemaTestHelpers.configuration.project_root = nil
        GovukContentSchemaTestHelpers.configuration.schema_type = nil
      end

      it 'raises an error' do
        expect { subject.new('foo',  '{}') }.to raise_error(GovukContentSchemaTestHelpers::ImproperlyConfiguredError, /schema file not found/i)
      end
    end
  end

  describe '#errors' do
    before do
      GovukContentSchemaTestHelpers.configuration.project_root = File.absolute_path(File.join(File.basename(__FILE__), '..'))
      GovukContentSchemaTestHelpers.configuration.schema_type = 'frontend'
    end

    after do
      GovukContentSchemaTestHelpers.configuration.project_root = nil
      GovukContentSchemaTestHelpers.configuration.schema_type = nil
    end

    describe 'with an invalid document' do
      it 'returns an array of errors from json-schema' do
        errors = subject.new('finder', '{}').errors
        expect(errors).to be_an(Array)
        expect(errors.first).to start_with("The property '#/' did not contain a required property of 'base_path'")
      end
    end
  end

  describe '#valid?' do
    before do
      GovukContentSchemaTestHelpers.configuration.project_root = File.absolute_path(File.join(File.basename(__FILE__), '..'))
      GovukContentSchemaTestHelpers.configuration.schema_type = 'frontend'
    end

    after do
      GovukContentSchemaTestHelpers.configuration.project_root = nil
      GovukContentSchemaTestHelpers.configuration.schema_type = nil
    end

    describe 'with an invalid document' do
      it 'returns false' do
        expect(subject.new('finder', '{}').valid?).to eql(false)
      end
    end
  end
end
