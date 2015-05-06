# govuk-content-schema-test-helpers

This app provides test helpers for working with [alphagov/govuk-content-schemas](https://github.com/alphagov/govuk-content-schemas). This consists of two things:

* code for validating a JSON document against a JSON schema in govuk-content-schemas
* code for fetching example JSON documents from govuk-content-schemas


## Technical documentation

### Dependencies

- [alphagov/govuk-content-schemas](https://github.com/alphagov/govuk-content-schemas) - contains the examples and schemas returned by this gem

### Usage

#### Configuration and setup

Firstly, you will need a copy of [govuk-content-schemas](http://github.com/alphagov/govuk-content-schemas) on your file system. By default these should be in a sibling directory to your project. Alternatively, you can specify their location with the `GOVUK_CONTENT_SCHEMAS_PATH` environment variable. You should probably duplicate this paragraph (excluding this sentence) in your own `README`.

You will need to configure which type of schemas your app uses. A good place to do this is in `test_helper.rb` or `spec/support/govuk_content_schemas.rb`:

```ruby
  require 'govuk-content-schema-test-helpers'

  GovukContentSchemaTestHelpers.configure do |config|
    config.schema_type = 'frontend' # or 'publisher'
    config.project_root = Rails.root
  end
```

If you are not using Rails, you'll need to set `project_root` differently. Assuming the file you are adding this to is one directory down from your project root:
```ruby
  config.project_root = File.absolute_path(File.join(File.basename(__FILE__), '..'))
```

#### Loading an example document

```ruby
  GovukContentSchemaTestHelpers::Examples.new.get('finder', 'contacts')
  # => '{ "some": "json" }'
```

#### Loading all examples for a given format


```ruby
  GovukContentSchemaTestHelpers::Examples.new.get_all_for_format('case_study')
  # => ['{ "first": "example"}', '{ "second": "example" }']
```

This would be useful for checking your app can handle all examples and any that come into existence later:

```ruby
  def supported_formats
    %w{
      case_study
      coming_soon
    }
  end

  def all_examples_for_supported_formats
    GovukContentSchemaTestHelpers::Examples.new.get_all_for_formats(supported_formats)
  end

  # In an ActionDispatch::IntegrationTest, for example:
  test 'that we can handle every example of the formats we support'
    all_examples_for_supported_formats.each do |example|
      content_item = JSON.parse(example)
      content_store_has_item(content_item['base_path'], content_item)

      get content_item['base_path']
      assert_response 200
      assert_select 'title', content_item['title']
    end
  end
```


#### RSpec matcher

To use the built-in RSpec matcher, add this to `spec/support/govuk_content_schemas.rb`:

```ruby
  require 'govuk-content-schema-test-helpers/rspec_matchers'
  RSpec.configuration.include GovukContentSchemaTestHelpers::RSpecMatchers
```

Then:
```
  expect(presented).to be_valid_against_schema('finder')
```

or as an argument matcher:

```ruby
  expect(publishing_api).to receive(:put_content_item)
        .with("/first-finder", be_valid_against_schema('finder'))
```

#### Test::Unit/Minitest

Setup:

```ruby
  require 'govuk-content-schema-test-helpers/test_unit'
  include GovukContentSchemaTestHelpers::TestUnit
```

Then in a test:
```ruby
  assert_valid_against_schema(presented_hash, 'case_study')
```

#### Validating against the schema manually

```ruby
  validator = GovukContentSchemaTestHelpers::Validator.new('finder', '{ "some": "json" }')
  validator.valid?
  # => false
  validator.errors
  # => ["The property '#/' did not contain a required property of 'base_path'", ...]
```

### Running the test suite

```
  bundle exec rake
```


## Licence

[MIT License](LICENCE)

## Versioning policy

This is versioned according to [Semantic Versioning 2.0](http://semver.org/).
