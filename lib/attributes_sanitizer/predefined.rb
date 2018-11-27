module AttributesSanitizer
  module Predefined
    extend ActiveSupport::Concern

    included do
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
        value.gsub(AttributesSanitizer::EMOJI_REGEX, '')
      end

      AttributesSanitizer.define_sanitizer :strip_spaces do |value|
        value.strip
      end
    end
  end
end

