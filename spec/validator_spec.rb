require 'spec_helper'

def a_valid_redirect_document
  {
    "format" => "redirect",
    "publishing_app" => "publisher",
    "update_type" => "major",
    "redirects" => [
      {"path" => "/foo", "type" => "prefix", "destination" => "/new-foo"},
    ]
  }
end

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
      base_path = GovukContentSchemaTestHelpers::Util.govuk_content_schemas_path
      expected_path = base_path + "/formats/minidisc/a-type/schema.json"
      expect(subject.schema_path('minidisc')).to eql(expected_path)
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
        GovukContentSchemaTestHelpers.configuration.project_root = File.join(File.dirname(__FILE__), '..')
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
      GovukContentSchemaTestHelpers.configuration.schema_type = 'publisher'
    end

    after do
      GovukContentSchemaTestHelpers.configuration.project_root = nil
      GovukContentSchemaTestHelpers.configuration.schema_type = nil
    end

    describe 'with a valid document' do
      it 'returns an empty array' do
        errors = subject.new('redirect', a_valid_redirect_document).errors
        expect(errors).to be_an(Array)
        expect(errors).to be_empty
      end
    end

    describe 'with an invalid document' do
      it 'returns an array of errors from json-schema' do
        errors = subject.new('finder', '{}').errors
        expect(errors).to be_an(Array)
        expect(errors.first).to start_with("The property '#/' did not contain a required property of 'format'")
      end
    end
  end

  describe '#valid?' do
    before do
      GovukContentSchemaTestHelpers.configuration.project_root = File.absolute_path(File.join(File.basename(__FILE__), '..'))
      GovukContentSchemaTestHelpers.configuration.schema_type = 'publisher'
    end

    after do
      GovukContentSchemaTestHelpers.configuration.project_root = nil
      GovukContentSchemaTestHelpers.configuration.schema_type = nil
    end

    describe 'with a valid document' do
      it 'returns true' do
        expect(subject.new('redirect', a_valid_redirect_document).valid?).to eql(true)
      end
    end

    describe 'with an invalid document' do
      it 'returns false' do
        expect(subject.new('finder', '{}').valid?).to eql(false)
      end
    end
  end
end
