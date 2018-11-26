require 'test_helper'

class AttributesSanitizer::Test < ActiveSupport::TestCase
  test "setup for individual attribute using a block sanitizer" do
    product = Product.new(title: 'Title 123', description: 'Description <b>123</b> 432')
    assert_equal 'title xxx', product.title
    assert_equal 'description 123 432', product.description
  end
end
