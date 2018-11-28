# frozen_string_literal: true
require 'test_helper'

class AttributesSanitizer::Bundle::Test < AttributesSanitizer::TestCase
  test "finds a bundle" do
    assert_nothing_raised do
      refute_nil AttributesSanitizer.bundle(:no_tags_emojis_or_extra_spaces)
    end
  end

  test "returns nil when no bundle can be found" do
    assert_nil AttributesSanitizer.bundle(:undefined_bundle)
  end

  test "can be configured with new bundles" do
    AttributesSanitizer.define_bundle :new_bundle, %i(downcase upcase)
    expected_sanitizers = [AttributesSanitizer.find(:downcase), AttributesSanitizer.find(:upcase)]
    assert_equal expected_sanitizers, AttributesSanitizer.bundle(:new_bundle)
  end

  test "raise error when defining a new bundle with invalid params" do
    assert_raise ArgumentError do
      AttributesSanitizer.define_bundle nil, nil
    end

    assert_raise ArgumentError do
      AttributesSanitizer.define_bundle :new_bundle, nil
    end

    assert_raise ArgumentError do
      AttributesSanitizer.define_bundle :new_bundle, []
    end
  end
end
