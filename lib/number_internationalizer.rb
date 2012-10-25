require "number_internationalizer/version"
require "number_internationalizer/helpers/internationalized_number_helper"
require "number_internationalizer/model_inclusions"
require "active_model/validations/internationalized_numericality_validator"

module NumberInternationalizer
  # Your code goes here...
  class << self
    def configure

      ActionView::Helpers::FormBuilder.class_eval do

        include NumberInternationalizer::Helpers::InternationalizedNumberHelper

        def number_field(field, options = {})
          value = object.send("#{field}_denormalized") if object.respond_to?("#{field}_denormalized".to_sym)
          value ||= object.send(field)
          options[:value] = value
          options[:class] = "#{options[:class]} number_field"
          text_field(field, options)
        end
        
      end

      AttributeNormalizer.configure do |config|

        config.normalizers[:number] = lambda do |value, options|
          separator = I18n.t('number.format.separator')
          delimiter = I18n.t('number.format.delimiter')
          value.respond_to?(:gsub) ? value.gsub(delimiter, '').gsub(separator,".").strip : value
        end
        
        config.normalizers[:percentage] = lambda do |value, options|
          separator = I18n.t('number.format.separator')
          delimiter = I18n.t('number.format.delimiter')
          value.respond_to?(:gsub) ? value.gsub(delimiter, '').gsub(separator,".").strip.gsub(/%$/,'').strip : value
        end

      end

    end
  end

 
end
