require 'spec_helper'

describe GovukContentSchemaTestHelpers::Util do
  let(:subject) { GovukContentSchemaTestHelpers::Util }

  around do |example|
    old_path = ENV['GOVUK_CONTENT_SCHEMAS_PATH']
    ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = schema_path
    GovukContentSchemaTestHelpers.configuration.schema_type = 'a-type'
    GovukContentSchemaTestHelpers.configuration.project_root = '/an/absolute/path'

    example.call

    ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = old_path
    GovukContentSchemaTestHelpers.configuration.schema_type = nil
    GovukContentSchemaTestHelpers.configuration.project_root = nil
  end

  describe '#govuk_content_schemas_path' do
    context 'GOVUK_CONTENT_SCHEMAS_PATH ENV var is not set' do
      let(:schema_path) { nil }

      it 'returns an absolute path, using the default relative path' do
        expect(subject.govuk_content_schemas_path).to eql('/an/absolute/govuk-content-schemas')
      end
    end

    context 'GOVUK_CONTENT_SCHEMAS_PATH ENV var is set to a relative path' do
      let(:schema_path) { "../a-custom-path" }

      it 'computes an absolute path by combining the project_root and environment variable' do
        expect(subject.govuk_content_schemas_path).to eql('/an/absolute/a-custom-path')
      end
    end

    context 'GOVUK_CONTENT_SCHEMAS_PATH ENV var is set to an absolute path' do
      let(:schema_path) { "/a/custom/absolute/path/" }

      it 'returns the value of GOVUK_CONTENT_SCHEMAS_PATH unchanged' do
        expect(subject.govuk_content_schemas_path).to eql('/a/custom/absolute/path/')
      end
    end
  end

  describe '#formats' do
    let(:schema_path) { fixture_path }

    it 'returns the list of formats from govuk-content-schemas' do
      expect(subject.formats).to include('minidisc')
    end
  end
end
