AttributesSanitizer.define_sanitizer :downcase do |value|
  value.to_s.downcase
end

AttributesSanitizer.define_sanitizer :upcase do |value|
  value.to_s.upcase
end

AttributesSanitizer.define_sanitizer :strip_tags do |value|
  ActionController::Base.helpers.sanitize(value.to_s, tags: []).strip
end

AttributesSanitizer.define_sanitizer :strip_emojis do |value|
  value.to_s.gsub(AttributesSanitizer::EMOJI_REGEX, '')
end

AttributesSanitizer.define_sanitizer :strip_spaces do |value|
  value.to_s.strip
end

