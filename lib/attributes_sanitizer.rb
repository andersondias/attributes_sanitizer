require "attributes_sanitizer/railtie"
require "attributes_sanitizer/sanitizer_proc"
require "attributes_sanitizer/concern"

#
# Attributes sanitizer for Rails
#
# A simple way to append sanitizers to attributes on Rails.
#
# ```ruby
# class Product < ApplicationRecord
#   extend AttributesSanitizer::Concern
#
#   sanitize_attribute :title, with: -> (value) {
#     value.gsub(/[1-9]/, 'X')
#   }
#
#   sanitize_attributes :title, :description, with: [:downcase, :strip_tags]
# end
# ```
#
# It comes with pre-defined sanitizers:
# - `:downcase` which downcases a given attribute string
# - `:upcase` which upcases a given attribute string
# - `:strip_tags` which removes any tags from the given string based on Rails sanitize helper.
# - `:strip_emojis` which removes any emoji from the given string
# - `:strip_spaces` which removes any white spaces from the beginning and end of given attribute
#
# You might define your own sanitizers:
#
# ```ruby
# # config/initializers/attribute_sanitizers.rb
#
# AttributesSanitizer.define_sanitizer :reverse do |value|
#   value.to_s.reverse
# end
# ```
module AttributesSanitizer
  EMOJI_REGEX = /[^\u0000-\u00FF]/

  cattr_accessor :sanitizers
  self.sanitizers = {}

  def self.define_sanitizer(sanitizer_name, &block)
    self.sanitizers[sanitizer_name.to_sym] = block
  end

  def self.setup_initial_getter_and_setter(klass, attribute)
    getter = attribute.to_sym
    setter = :"#{attribute}="

    unless klass.method_defined?(getter)
      klass.define_method getter do
        super()
      end
    end

    unless klass.method_defined?(setter)
      klass.define_method setter do |new_value|
        super(new_value)
      end
    end

    [getter, setter]
  end

  def self.override_attribute_with_sanitizer(klass, attribute, sanitizer)
    getter, setter = setup_initial_getter_and_setter(klass, attribute)

    original_getter_alias = "#{attribute}_before_#{sanitizer.id}"
    klass.alias_method original_getter_alias, getter

    original_setter_alias = "#{attribute}_before_#{sanitizer.id}="
    klass.alias_method original_setter_alias, setter

    klass.define_method getter do
      sanitizer.call(send(original_getter_alias))
    end

    klass.define_method setter do |new_value|
      send(original_setter_alias, sanitizer.call(new_value))
    end
  end
end

require "attributes_sanitizer/predefined"
