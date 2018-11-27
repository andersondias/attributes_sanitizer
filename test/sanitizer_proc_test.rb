require 'test_helper'

class AttributesSanitizer::SanitizerProc::Test < ActiveSupport::TestCase
  test "may receive a proc as param" do
    sanitizer_lambda = lambda { |v| v.to_s + 'b' }

    sanitizer = AttributesSanitizer::SanitizerProc.new(sanitizer_lambda)
    assert_equal sanitizer_lambda.object_id, sanitizer.id
    assert_equal 'ab', sanitizer.call('a')
  end

  test "may receive a valid pre-defined sanitizer" do
    sanitizer = AttributesSanitizer::SanitizerProc.new(:strip_spaces)
    assert_equal :strip_spaces, sanitizer.id
    assert_equal 'a', sanitizer.call('a ')
  end

  test "raises error for invalid pre-defined sanitizer" do
    assert_raise ArgumentError, "No attribute sanitizer defined for strip_spacess" do
      AttributesSanitizer::SanitizerProc.new(:strip_spacess)
    end
  end

  test "raises error for nil proc" do
    assert_raise ArgumentError, "No sanitizer given" do
      AttributesSanitizer::SanitizerProc.new(nil)
    end
  end

  test "comparable" do
    sanitizer_lambda = lambda { |v| v.to_s + 'b' }

    sanitizer_with_lambda = AttributesSanitizer::SanitizerProc.new(sanitizer_lambda)
    sanitizer_with_lambda_copy = AttributesSanitizer::SanitizerProc.new(sanitizer_lambda)
    sanitizer_with_predefined_rule = AttributesSanitizer::SanitizerProc.new(:strip_spaces)
    sanitizer_with_predefined_rule_copy = AttributesSanitizer::SanitizerProc.new(:strip_spaces)
    another_sanitizer_with_predefined_rule = AttributesSanitizer::SanitizerProc.new(:strip_emojis)

    assert_equal sanitizer_with_lambda, sanitizer_with_lambda_copy
    assert_equal sanitizer_with_predefined_rule, sanitizer_with_predefined_rule_copy
    refute_equal sanitizer_with_lambda, sanitizer_with_predefined_rule
    refute_equal sanitizer_with_predefined_rule, another_sanitizer_with_predefined_rule
  end
end
