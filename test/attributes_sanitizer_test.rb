require 'test_helper'

class AttributesSanitizer::Test < AttributesSanitizer::TestCase
  test "can be configured with new sanitizers" do
    new_sanitizer_proc = lambda { |value| 'a' }

    AttributesSanitizer.define_sanitizer :new_sanitizer, &new_sanitizer_proc
    assert_equal new_sanitizer_proc, AttributesSanitizer.sanitizers[:new_sanitizer]
  end

  test "raise error when defining a new sanitizer without a block" do
    assert_raise ArgumentError do
      AttributesSanitizer.define_sanitizer :new_sanitizer
    end
  end
end
