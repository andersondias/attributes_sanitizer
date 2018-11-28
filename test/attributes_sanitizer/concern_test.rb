# frozen_string_literal: true
require 'test_helper'

class AttributesSanitizer::Concern::Test < AttributesSanitizer::TestCase
  test "setting up a pre-defined sanitizer to single attribute" do
    Product.sanitize_attribute :title, with: :strip_spaces
    assert_equal [:title], Product.attributes_sanitize_map.keys
    product = Product.new(title: '  Title 123   ', description: '  Description ')
    assert_sanitized_attribute product, :title, 'Title 123'
    assert_sanitized_attribute product, :description, '  Description '
  end

  test "setting up a pre-defined sanitizer to multiple attributes" do
    Product.sanitize_attributes :title, :description, with: :strip_spaces
    assert_equal [:title, :description], Product.attributes_sanitize_map.keys
    product = Product.new(title: '  Title 123   ', description: '  Description ')
    assert_sanitized_attribute product, :title, 'Title 123'
    assert_sanitized_attribute product, :description, 'Description'
  end

  test "setting up a list of pre-defined sanitizers to model" do
    Product.sanitize_attribute :title, with: [:strip_spaces, :upcase]
    assert_equal [:title], Product.attributes_sanitize_map.keys
    product = Product.new(title: '  Title 123   ')
    assert_sanitized_attribute product, :title, 'TITLE 123'
  end

  test "setting up a list of pre-defined sanitizers to model in multiple lines" do
    Product.sanitize_attribute :title, with: :strip_spaces
    Product.sanitize_attribute :title, with: :upcase

    assert_equal [:title], Product.attributes_sanitize_map.keys
    product = Product.new(title: '  Title 123   ')
    assert_sanitized_attribute product, :title, 'TITLE 123'
  end

  test "setting up block sanitizer to model" do
    Product.sanitize_attribute :title, with: lambda { |value| value.gsub(/[1-9]/, 'X') }
    assert_equal [:title], Product.attributes_sanitize_map.keys
    product = Product.new(title: '  Title 123   ')
    assert_sanitized_attribute product, :title, '  Title XXX   '
  end

  test "sanitizes when calling setter" do
    Product.sanitize_attribute :title, with: :upcase

    product = Product.new
    assert_nil product.title

    product.title = 'title'
    assert_sanitized_attribute product, :title, 'TITLE'
  end

  test "sanitizes when assign attributes" do
    Product.sanitize_attribute :title, with: :upcase

    product = Product.new
    assert_nil product.title

    product.assign_attributes title: 'title'
    assert_sanitized_attribute product, :title, 'TITLE'
  end

  test "sanitizes when assign attributes on initialization" do
    Product.sanitize_attribute :title, with: :upcase

    product = Product.new(title: 'title')
    assert_sanitized_attribute product, :title, 'TITLE'
  end

  test "sanitizes when creating a record" do
    Product.sanitize_attribute :title, with: :upcase

    product = Product.create!(title: 'title')
    assert_sanitized_attribute product, :title, 'TITLE'
  end

  test "sanitizes when updating a record" do
    Product.sanitize_attribute :title, with: :upcase

    product = Product.create!
    assert_nil product.title

    product.update_attributes title: 'title'
    assert_sanitized_attribute product, :title, 'TITLE'

    product.update_attribute :title, 'titlee'
    assert_sanitized_attribute product, :title, 'TITLEE'

    product.update title: 'titleee'
    assert_sanitized_attribute product, :title, 'TITLEEE'
  end

  test "sanitizes when reading" do
    Product.sanitize_attribute :title, with: :upcase

    product = Product.create!
    assert_nil product.title

    product.update_column :title, 'title'
    assert_sanitized_attribute product, :title, 'TITLE', on: :instance_only
  end

  test "sanitizes when writing attribute" do
    Product.sanitize_attribute :title, with: :upcase

    product = Product.new
    assert_nil product.title

    product.write_attribute :title, 'title'
    assert_sanitized_attribute product, :title, 'TITLE', on: :instance_only
  end

  test "does not raise error when declarating sanitizer twice to same attribute" do
    Product.sanitize_attribute :title, with: [:strip_emojis, :strip_emojis]
  end

  test "does not change value for nil attribute" do
    Product.sanitize_attribute :title, with: :upcase
    product = Product.new
    assert_nil product.title
    assert_nil product.description
  end

  test "setup is not shared between models" do
    Product.sanitize_attribute :title, with: :upcase
    refute_equal Product.attributes_sanitize_map.object_id, Post.attributes_sanitize_map.object_id
    assert_equal [:title], Product.attributes_sanitize_map.keys
    assert_equal [], Post.attributes_sanitize_map.keys
  end
end
