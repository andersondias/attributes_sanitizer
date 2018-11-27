module AttributesSanitizer
  class Overrider
    attr_reader :klass

    def initialize(klass)
      @klass = klass
    end

    def override_getters_and_setters
      return if klass.attributes_sanitize_map.blank?

      klass.attributes_sanitize_map.each_pair do |attribute, _|
        getter = attribute.to_sym
        setter = :"#{attribute}="

        unless klass.method_defined?(getter)
          klass.define_method getter do
            attribute_value = self[getter.to_s]
            return if attribute_value.nil?

            self.class.execute_sanitizers_for(attribute, attribute_value)
          end
        end

        unless klass.method_defined?(setter)
          klass.define_method(setter) do |new_value|
            if new_value.present?
              new_value = self.class.execute_sanitizers_for(attribute, new_value)
            end

            super(new_value)
          end
        end
      end
    end
  end
end
