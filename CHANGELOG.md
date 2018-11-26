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
