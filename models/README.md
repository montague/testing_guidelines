## Guidelines for Model Specs

* stubs/mocks can be a smell, so if you find yourself reaching for them
  often, reevaluate
* shoulda-matchers (https://github.com/thoughtbot/shoulda-matchers) are good
  * active record is complicated and it's easy to use macros incorrectly
    in subtle ways
* focusing on testability will help emphasize SRP
