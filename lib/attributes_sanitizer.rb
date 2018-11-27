require "attributes_sanitizer/railtie"
require "attributes_sanitizer/sanitizer_proc"
require "attributes_sanitizer/concern"
require "attributes_sanitizer/overrider"
require "attributes_sanitizer/predefined"

module AttributesSanitizer
  EMOJI_REGEX = /[^\u0000-\u00FF]/

  mattr_accessor :sanitizers
  self.sanitizers = {}

  def self.define_sanitizer(sanitizer_name, &block)
    raise ArgumentError, 'sanitizer needs a block' unless block_given?
    self.sanitizers[sanitizer_name.to_sym] = block
  end

  include Predefined
end
