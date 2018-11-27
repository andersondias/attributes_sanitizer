# 0.1.1

First stable version.

- Fix bug with duplicated sanitizer name on fields declaration
- Add possibility to stack the validations in order of decalration. Example: `sanitize_attributes :title, with: [:stringify, :strip_tags, :strip_spaces]` -> `strinfigy` will be the first executed, and `strip_spaces` the last.
- Added `:stringify` as default sanitizer, to perform a `.to_s` on attribute

# 0.1.0

Initial version.

Includes the default methods:

- `:downcase` which downcases a given attribute string
- `:upcase` which upcases a given attribute string
- `:strip_tags` which removes any tags from the given string based on Rails sanitize helper.
- `:strip_emojis` which removes any emoji from the given string
- `:strip_spaces` which removes any white spaces from the beginning and end of given attribute

Or custom Sanitizers, using:

```
AttributesSanitizer.define_sanitizer :reverse do |value|
  value.to_s.reverse
end
```
