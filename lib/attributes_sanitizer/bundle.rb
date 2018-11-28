# frozen_string_literal: true
module AttributesSanitizer
  module Bundle
    def define_bundle(bundle_name, keys)
      raise ArgumentError, 'empty bundle name' if bundle_name.blank?

      keys = Array(keys)
      raise ArgumentError, 'empty keys' if keys.blank?

      @bundles ||= {}
      @bundles[bundle_name.to_sym] = keys
    end

    def bundle(bundle_name)
      bundle = @bundles[bundle_name.to_sym]
      bundle&.map do |sanitizer_name|
        find(sanitizer_name)
      end
    end
  end
end
