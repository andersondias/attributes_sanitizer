[![Maintainability](https://api.codeclimate.com/v1/badges/29a55c3bd2dd9e5ed117/maintainability)](https://codeclimate.com/github/andersondias/attributes_sanitizer/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/29a55c3bd2dd9e5ed117/test_coverage)](https://codeclimate.com/github/andersondias/attributes_sanitizer/test_coverage) [![Build](https://travis-ci.org/andersondias/attributes_sanitizer.svg?branch=master)](https://travis-ci.org/andersondias/attributes_sanitizer.svg?branch=master)

# AttributesSanitizer

A simple way to append sanitizers to attributes on Rails.


## Usage

```ruby
class Product < ApplicationRecord
  sanitize_attribute :title, with: -> (value) {
    value.gsub(/[1-9]/, 'X')
  }

  sanitize_attributes :title, :description, with: [:downcase, :strip_tags]
end
```

It comes with pre-defined sanitizers:
- `:stringify` which perform a `to_s` into the value, to be sanitized as a string. Can be used before other sanitizer, that depends to the value be a string
- `:downcase` which downcases a given attribute string
- `:upcase` which upcases a given attribute string
- `:strip_tags` which removes any tags from the given string based on Rails sanitize helper.
- `:strip_emojis` which removes any emoji from the given string
- `:strip_spaces` which removes any white spaces from the beginning and end of given attribute

You might define your own sanitizers:

```ruby
# config/initializers/attribute_sanitizers.rb

AttributesSanitizer.define_sanitizer :reverse do |value|
  value.to_s.reverse
end
```

It also comes with predefined bundles:
```ruby
class Product < ApplicationRecord
  sanitize_attribute :title, with: -> (value) {
    value.gsub(/[1-9]/, 'X')
  }

  sanitize_attributes :title, :description, with: :no_tags_emojis_or_extra_spaces
  # same as: `with: %i(stringify strip_tags strip_emojis strip_spaces)
end
```

And, finally, you are able to define your own bundles:
```ruby
# config/initializers/attribute_sanitizers.rb
AttributesSanitizer.define_bundle(:my_bundle, %i(downcase strip_spaces))
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'attributes_sanitizer'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install attributes_sanitizer
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
