module AttributesSanitizer
  module ActiveRecordTestHelper
    extend ActiveSupport::Concern

    class_methods do
      def clear_sanitized_attributes(*attributes)
        attributes.each do |attribute|
          if method_defined?(attribute)
            undef_method(attribute)
            undef_method(:"#{attribute}=")
          end
        end
        self.attributes_sanitize_map.clear
      end
    end
  end
end
