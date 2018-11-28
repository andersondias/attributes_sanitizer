# frozen_string_literal: true
module AttributesSanitizer
  class SanitizerProc
    include Comparable

    attr_reader :id

    def initialize(sanitizer)
      raise ArgumentError, "No sanitizer given" if sanitizer.nil?

      if sanitizer.is_a?(Proc)
        setup_lambda_proc(sanitizer)
      else
        setup_defined_proc(sanitizer)
      end
    end

    def <=>(another_proc)
      self.id <=> another_proc.id
    end

    def call(value)
      @proc.inject(value) do |value, proc|
        proc.call(value)
      end
    end

    private

      def setup_lambda_proc(sanitizer)
        @proc = Array(sanitizer)
        @id = sanitizer.object_id
      end

      def setup_defined_proc(sanitizer)
        @id = sanitizer
        @proc = AttributesSanitizer.bundle(sanitizer) || Array(AttributesSanitizer.find(sanitizer))
      end
  end
end
