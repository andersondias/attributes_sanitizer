# frozen_string_literal: true
require "attributes_sanitizer/railtie"
require "attributes_sanitizer/sanitizer_proc"
require "attributes_sanitizer/concern"
require "attributes_sanitizer/overrider"
require "attributes_sanitizer/bundle"
require "attributes_sanitizer/sanitizers"
require "attributes_sanitizer/predefined"

module AttributesSanitizer
  extend Sanitizers, Bundle
  # must to be called here in order to ensure extension of upper modules
  extend Predefined
end
