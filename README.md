# govuk-content-schema-test-helpers

This app provides test helpers for working with [alphagov/govuk-content-schemas](https://github.com/alphagov/govuk-content-schemas). This consists of two things:

* code for validating a JSON document against a JSON schema in govuk-content-schemas
* code for fetching example JSON documents from govuk-content-schemas


## Technical documentation

### Dependencies

- [alphagov/govuk-content-schemas](https://github.com/alphagov/govuk-content-schemas) - contains the examples and schemas returned by this gem

### Usage

You will need to configure which context your app is in. A good place to do this is in `test_helper.rb` or `spec_helper.rb`:

```ruby
  require 'govuk-content-schema-test-helpers'

  GovukContentSchemaTestHelpers.configure do |config|
    config.schema_type = 'frontend'
    config.project_root = Rails.root
  end
```

`schema_type` should be one of `frontend` or `publisher` depending upon which type of document you want to validate.

If you are not using Rails, you'll need to set `project_root` differently. Assuming the file you are adding this to is one directory down from your project root:
```ruby
  config.project_root = File.absolute_path(File.join(File.basename(__FILE__), '..'))
```

To load an example document:

```ruby
  GovukContentSchemaTestHelpers::Examples.new.get('finder', 'contacts')
  # => '{ "some": "json" }'
```

To validate a document against the schema:

```ruby
  validator = GovukContentSchemaTestHelpers::Validator.new('finder', '{ "some": "json" }')
  validator.valid?
  # => false
  validator.errors
  # => ["The property '#/' did not contain a required property of 'base_path'", ...]
```


### Running the test suite

The tests in this project rely upon [govuk-content-schemas](http://github.com/alphagov/govuk-content-schemas). By default these should be in the parent directory, otherwise you can specify their location with the `GOVUK_CONTENT_SCHEMAS_PATH` environment variable.

Assuming you already have govuk-content-schemas cloned:

```
  bundle exec rake
```


## Licence

[MIT License](LICENCE)

## Versioning policy

This is versioned according to [Semantic Versioning 2.0](http://semver.org/).
