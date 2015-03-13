# CHANGELOG

## 1.0.1

* Bugfix: only lib/govuk-content-schema-test-helpers.rb was being included, so
the gem was unusable. Errors raised were along the lines of:
  ```
  cannot load such file -- govuk-content-schema-test-helpers/configuration (LoadError)
  ```

## 1.0.0 (Broken, use 1.0.1)

* Initial version. Includes code for loading example documents, validating
  against schemas, RSpec matchers and Test::Unit/Minitest assertions.
