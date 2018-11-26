class Product < ApplicationRecord
  sanitize_attribute :title, with: -> (value) {
    value.gsub(/[1-9]/, 'X')
  }

  sanitize_attributes :title, :description, with: [:downcase, :strip_tags]
end
