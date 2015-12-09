require 'spec_helper'

def a_valid_minidisc_document
  {
    "format" => "minidisc",
  }
end

describe GovukContentSchemaTestHelpers::Validator do
  let(:subject) { GovukContentSchemaTestHelpers::Validator }

  around do |example|
    old_path = ENV['GOVUK_CONTENT_SCHEMAS_PATH']
    ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = schema_path
    GovukContentSchemaTestHelpers.configuration.schema_type = schema_type

    example.call

    ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = old_path
    GovukContentSchemaTestHelpers.configuration.schema_type = nil
  end

  describe '#initialize' do
    describe 'when the govuk-content-schemas directory does not exist' do
      let(:schema_path) { "/non-existent-path" }
      let(:schema_type) { "frontend" }

      it 'raises an error' do
        expect { subject.new('foo',  '{}') }.to raise_error(GovukContentSchemaTestHelpers::ImproperlyConfiguredError, /govuk-content-schemas cannot be found/)
      end
    end
  end

  describe '#errors' do
    let(:schema_path) { fixture_path }
    let(:schema_type) { "publisher" }

    describe 'with a valid document' do
      it 'returns an empty array' do
        errors = subject.new('minidisc', a_valid_minidisc_document).errors
        expect(errors).to be_an(Array)
        expect(errors).to be_empty
      end
    end

    describe 'with an invalid document' do
      it 'returns an array of errors from json-schema' do
        errors = subject.new('minidisc', '{}').errors
        expect(errors).to be_an(Array)
        expect(errors.first).to start_with("The property '#/' did not contain a required property of 'format'")
      end
    end
  end

  describe '#valid?' do
    let(:schema_path) { fixture_path }
    let(:schema_type) { "publisher" }

    describe 'with a valid document' do
      it 'returns true' do
        expect(subject.new('minidisc', a_valid_minidisc_document).valid?).to eql(true)
      end
    end

    describe 'with an invalid document' do
      it 'returns false' do
        expect(subject.new('minidisc', '{}').valid?).to eql(false)
      end
    end

    describe 'when the schema file does not exist' do
      let(:schema_path) { fixture_path }
      let(:schema_type) { "a-non-existent-type" }

      it 'raises an error' do
        expect { subject.new('foo',  '{}').valid? }.to raise_error(GovukContentSchemaTestHelpers::ImproperlyConfiguredError, /schema file not found/i)
      end
    end
  end
end
