require "attributes_sanitizer/railtie"
require "attributes_sanitizer/sanitizer_proc"
require "attributes_sanitizer/concern"
require "attributes_sanitizer/overrider"
require "attributes_sanitizer/predefined"

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

  include Predefined
end
