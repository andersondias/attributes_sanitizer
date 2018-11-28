module AttributesSanitizer
  module TestHelper
    extend ActiveSupport::Concern

    class_methods do
      def reset_to_predefined
        predefined_sanitizers = @bundles[:predefined]
        @sanitizers.keep_if do |sanitizer|
          predefined_sanitizers.include?(sanitizer)
        end
        @bundles.keep_if do |key, _|
          @predefined_bundles.include?(key)
        end
      end
    end
  end
end
