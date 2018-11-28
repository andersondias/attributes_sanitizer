# frozen_string_literal: true
module AttributesSanitizer
  module Predefined
    EMOJI_REGEX = /[^\u0000-\u00FF]/

    def setup_predefined_bundles
      define_bundle(:predefined, @sanitizers.keys)
      define_bundle(:no_tags_emojis_or_extra_spaces, %i(stringify strip_tags strip_emojis strip_spaces))
      @predefined_bundles = @bundles.keys
    end

    def self.extended(_)
      AttributesSanitizer.define_sanitizer :stringify do |value|
        value.to_s
      end

      AttributesSanitizer.define_sanitizer :downcase do |value|
        value.downcase
      end

      AttributesSanitizer.define_sanitizer :upcase do |value|
        value.upcase
      end

      AttributesSanitizer.define_sanitizer :strip_tags do |value|
        ActionController::Base.helpers.sanitize(value, tags: [])
      end

      AttributesSanitizer.define_sanitizer :strip_emojis do |value|
        value.gsub(AttributesSanitizer::Predefined::EMOJI_REGEX, '')
      end

      AttributesSanitizer.define_sanitizer :strip_spaces do |value|
        value.strip
      end

      AttributesSanitizer.setup_predefined_bundles
    end
  end
end
