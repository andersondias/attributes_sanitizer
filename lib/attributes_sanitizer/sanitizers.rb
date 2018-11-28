# frozen_string_literal: true
module AttributesSanitizer
  module Sanitizers
    def define_sanitizer(sanitizer_name, &block)
      @sanitizers ||= {}
      raise ArgumentError, 'sanitizer needs a block' unless block_given?
      @sanitizers[sanitizer_name.to_sym] = block
    end

    def find(sanitizer_name)
      sanitizer = @sanitizers && @sanitizers[sanitizer_name.to_sym]
      raise ArgumentError, "No sanitizer defined for #{sanitizer_name}" if sanitizer.nil?
      sanitizer
    end
  end
end
