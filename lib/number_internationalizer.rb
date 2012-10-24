require "number_internationalizer/version"
require "number_internationalizer/model_inclusions"
require "active_model/validations/internationalized_numericality_validator"

module NumberInternationalizer
  # Your code goes here...
  class << self
    def configure

      ActionView::Helpers::FormBuilder.class_eval do

        def number_field(field, options = {})
          value = object.send("#{field}_before_normalize").to_s if object.respond_to?("#{field}_before_normalize".to_sym)
          value ||= object.send(field).to_s
          options[:value] = value
          options[:class] = "#{options[:class]} number_field"
          text_field(field, options)
        end

      end

      AttributeNormalizer.configure do |config|

        config.normalizers[:number] = lambda do |value, options|
          separator = I18n.t('number.format.separator')
          delimiter = I18n.t('number.format.delimiter')
          value.gsub(delimiter, '').gsub(separator,".")
        end

      end

    end
  end

 
end