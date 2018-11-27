module AttributesSanitizer::Concern
  def self.extended(klass)
    klass.cattr_accessor :attributes_sanitize_map
    klass.extend ClassMethods
  end

  module ClassMethods
    def sanitize_attributes(*attributes)
      self.attributes_sanitize_map ||= {}

      defaults = attributes.extract_options!.dup
      sanitizers = Array(defaults[:with])

      raise ArgumentError, "You need to supply at least one attribute" if attributes.empty?
      raise ArgumentError, "You need to supply at least one sanitize method" if sanitizers.empty?

      sanitizers.each do |sanitizer|
        sanitizer = AttributesSanitizer::SanitizerProc.new(sanitizer)

        attributes.each do |attribute|
          self.attributes_sanitize_map[attribute] ||= []
          unless self.attributes_sanitize_map[attribute].include?(sanitizer)
            self.attributes_sanitize_map[attribute] << sanitizer
          end
        end

        AttributesSanitizer::Overrider.new(self).override_getters_and_setters
      end
    end
    alias_method :sanitize_attribute, :sanitize_attributes

    def execute_sanitizers_for(attribute, value)
      return value if self.attributes_sanitize_map.blank? || value.nil?

      self.attributes_sanitize_map[attribute].reduce(value) do |value, sanitizer|
        sanitizer.call(value)
      end
    end
  end
end
