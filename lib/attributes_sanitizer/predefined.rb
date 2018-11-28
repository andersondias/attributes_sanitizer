module AttributesSanitizer
  module Predefined
    extend ActiveSupport::Concern

    EMOJI_REGEX = /[^\u0000-\u00FF]/

    included do
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
    end
  end
end
