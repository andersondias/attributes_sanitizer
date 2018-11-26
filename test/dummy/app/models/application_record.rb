class ApplicationRecord < ActiveRecord::Base
  extend AttributesSanitizer::Concern
  self.abstract_class = true
end
