module AttributesSanitizer::Concern
  def self.extended(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def sanitize_attributes(*attributes)
      defaults = attributes.extract_options!.dup
      sanitizers = Array(defaults[:with])

      raise ArgumentError, "You need to supply at least one attribute" if attributes.empty?
      raise ArgumentError, "You need to supply at least one sanitize method" if sanitizers.empty?

      sanitizers.each do |sanitizer|
        sanitizer = AttributesSanitizer::SanitizerProc.new(sanitizer)

        attributes.each do |attribute|
          AttributesSanitizer::Overrider.new(self, attribute, sanitizer).redefine_attribute
        end
      end
    end

    alias_method :sanitize_attribute, :sanitize_attributes
  end
end
