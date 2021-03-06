# CHANGELOG

## 1.6.1

* Change `File.exists?` to `File.exist?` to stop deprecation messages

## 1.6.0

* Update json-schema dependency.

## 1.5.0

* Allow looking up examples to work with schemas stored in
formats/{format}/{schema_type}/examples/ and examples/{format}/{schema_type}/
to allow schema examples to move.

## 1.4.0

* Improve the test output for schema validation.
* Enable testing against the `links` schemas with `be_valid_against_links_schema`.

## 1.3.0

* Feature: add support for the new directory structure of govuk-content-schemas,
whereby the location of the schemas (which are compiled) will move into the
`dist/` directory. Apps validating against schemas (generally just publishing
apps) should upgrade as soon as possible. Support for the older directory
structure is retained but will be removed once all clients have been upgraded
and govuk-content-schemas has been changed.

## 1.2.0

* Feature: add GovukContentSchemaTestHelpers::Util.formats to get a list of
the formats defined in govuk-content-schemas.

## 1.1.0

* Feature: load all examples for a format or formats

## 1.0.2

* Bugfix: avoid deprecation warning with rspec 3.2:
  ```
  `failure_message_for_should` is deprecated. Use `failure_message` instead
  ```

## 1.0.1

* Bugfix: only lib/govuk-content-schema-test-helpers.rb was being included, so
the gem was unusable. Errors raised were along the lines of:
  ```
  cannot load such file -- govuk-content-schema-test-helpers/configuration (LoadError)
  ```

## 1.0.0 (Broken, use 1.0.1)

* Initial version. Includes code for loading example documents, validating
  against schemas, RSpec matchers and Test::Unit/Minitest assertions.
