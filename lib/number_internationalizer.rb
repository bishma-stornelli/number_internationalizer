require "number_internationalizer/version"
require "number_internationalizer/model_inclusions"
require "active_model/validations/internationalized_numericality_validator"
require "number_internationalizer/helpers/internationalized_number_helper"

module NumberInternationalizer
  # Your code goes here...
  class << self
    def configure

      ActionView::Helpers::FormBuilder.class_eval do

        include NumberInternationalizer::Helpers::InternationalizedNumberHelper

        def number_field(field, options = {})
          value = object.send("#{field}_before_normalize") if object.respond_to?("#{field}_before_normalize".to_sym)
          value ||= object.send(field)
          value = value.is_a?(String) ? value : display_as_number(value.to_s)
          options[:value] = value
          options[:class] = "#{options[:class]} number_field"
          text_field(field, options)
        end

      end

      AttributeNormalizer.configure do |config|

        config.normalizers[:number] = lambda do |value, options|
          separator = I18n.t('number.format.separator')
          delimiter = I18n.t('number.format.delimiter')
          value.respond_to?(:gsub) ? value.gsub(delimiter, '').gsub(separator,".") : value
        end

      end

    end
  end

 
end
