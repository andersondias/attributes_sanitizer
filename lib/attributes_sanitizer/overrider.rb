module AttributesSanitizer
  class Overrider
    attr_reader :klass, :attribute, :sanitizer, :getter, :setter

    def initialize(klass, attribute, sanitizer)
      @klass = klass
      @sanitizer = sanitizer
      @attribute = attribute
      @getter = attribute.to_sym
      @setter = :"#{attribute}="

      setup_initial_getter_and_setter
    end

    def redefine_attribute
      override_attribute_getter
      override_attribute_setter
    end

    private

      def setup_initial_getter_and_setter
        unless klass.method_defined?(getter)
          klass.define_method getter do
            super()
          end
        end

        unless klass.method_defined?(setter)
          klass.define_method setter do |new_value|
            super(new_value)
          end
        end
      end

    def override_attribute_getter
      original_getter_alias = "#{attribute}_before_#{sanitizer.id}"
      return if klass.method_defined?(original_getter_alias)
      sanitizer = self.sanitizer

      klass.alias_method original_getter_alias, getter
      klass.define_method getter do
        sanitizer.call(send(original_getter_alias))
      end
    end

    def override_attribute_setter
      original_setter_alias = "#{attribute}_before_#{sanitizer.id}="
      return if klass.method_defined?(original_setter_alias)
      sanitizer = self.sanitizer

      klass.alias_method original_setter_alias, setter
      klass.define_method setter do |new_value|
        send(original_setter_alias, sanitizer.call(new_value))
      end
    end
  end
end
