module AttributesSanitizer
  class Railtie < ::Rails::Railtie
    initializer 'attributes_sanitizer.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, AttributesSanitizer::Concern)
      end
    end
  end
end
