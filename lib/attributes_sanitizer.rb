# frozen_string_literal: true
require "attributes_sanitizer/railtie"
require "attributes_sanitizer/sanitizer_proc"
require "attributes_sanitizer/concern"
require "attributes_sanitizer/overrider"
require "attributes_sanitizer/predefined"

module AttributesSanitizer
  def self.define_sanitizer(sanitizer_name, &block)
    @sanitizers ||= {}
    raise ArgumentError, 'sanitizer needs a block' unless block_given?
    @sanitizers[sanitizer_name.to_sym] = block
  end

  def self.find(sanitizer_name)
    sanitizer = @sanitizers && @sanitizers[sanitizer_name.to_sym]
    raise ArgumentError, "No sanitizer defined for #{sanitizer}" if sanitizer.nil?
    sanitizer
  end

  include Predefined
end
