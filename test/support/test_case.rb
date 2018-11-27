module AttributesSanitizer
  class TestCase < ActiveSupport::TestCase
    def assert_sanitized_attribute(object, attribute, expected_value, on: :database)
      assert_equal expected_value, object.public_send(attribute), 'reading attribute via getter'

      if on == :database
        assert_equal expected_value, object[attribute], 'reading attribute via attributes hash'
        assert_equal expected_value, object.read_attribute(attribute), 'reading attribute via read_attribute'
      end
    end

    setup do
      Product.clear_sanitized_attributes(:title, :description)
      Product.attributes_sanitize_map&.clear
    end
  end
end
