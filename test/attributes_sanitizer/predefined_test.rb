require 'test_helper'

class AttributesSanitizer::Predefined::Test < AttributesSanitizer::TestCase
  test "downcase sanitizer" do
    Product.sanitize_attribute :title, with: :downcase
    product = Product.new(title: 'Title <b>123</b> 😀  ')
    assert_sanitized_attribute product, :title, 'title <b>123</b> 😀  '
  end

  test "upcase sanitizer" do
    Product.sanitize_attribute :title, with: :upcase
    product = Product.new(title: 'Title <b>123</b> 😀  ')
    assert_sanitized_attribute product, :title, 'TITLE <B>123</B> 😀  '
  end

  test "strip_tags sanitizer" do
    Product.sanitize_attribute :title, with: :strip_tags
    product = Product.new(title: 'Title <b>123</b> 😀  ')
    assert_sanitized_attribute product, :title, 'Title 123 😀  '
  end

  test "strip_emojis sanitizer" do
    Product.sanitize_attribute :title, with: :strip_emojis
    product = Product.new(title: 'Title <b>123</b> 😀  ')
    assert_sanitized_attribute product, :title, 'Title <b>123</b>   '
  end

  test "strip_spaces sanitizer" do
    Product.sanitize_attribute :title, with: :strip_spaces
    product = Product.new(title: 'Title <b>123</b> 😀  ')
    assert_sanitized_attribute product, :title, 'Title <b>123</b> 😀'
  end

  test "stringify sanitizer" do
    Product.sanitize_attribute :title, with: :stringify
    product = Product.new(title: 123)

    assert_sanitized_attribute product, :title, '123'
  end
end
