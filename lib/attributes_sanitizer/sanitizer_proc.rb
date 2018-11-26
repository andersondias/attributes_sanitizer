class SanitizerProc
  attr_reader :id

  def initialize(sanitizer)
    if sanitizer.is_a?(Proc)
      @proc = sanitizer
      @id = sanitizer.object_id
    else
      @proc = AttributesSanitizer.sanitizers[sanitizer]
      raise ArgumentError, "No attribute sanitizer defined for #{sanitizer}" if @proc.nil?

      @id = sanitizer
    end
  end

  def call(value)
    @proc.call(value)
  end
end
