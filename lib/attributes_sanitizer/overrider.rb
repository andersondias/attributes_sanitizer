module AttributesSanitizer
  class Overrider
    attr_reader :klass

    def initialize(klass)
      @klass = klass
    end

    def override_getters_and_setters
      return if klass.attributes_sanitize_map.blank?

      attributes_to_override.each do |attribute|
        override_getter(attribute)
        override_setter(attribute)
      end
    end

    private

      def attributes_to_override
        klass.attributes_sanitize_map.keys
      end

      def override_method(method_name, &block)
        return if klass.method_defined?(method_name)
        klass.define_method(method_name, &block)
      end

      def override_getter(attribute)
        getter = attribute.to_sym
        override_method(getter) do
          attribute_value = self[getter.to_s]
          return if attribute_value.nil?

          self.class.execute_sanitizers_for(attribute, attribute_value)
        end
      end

      def override_setter(attribute)
        override_method(:"#{attribute}=") do |new_value|
          if new_value.present?
            new_value = self.class.execute_sanitizers_for(attribute, new_value)
          end

          super(new_value)
        end
      end
  end
end
