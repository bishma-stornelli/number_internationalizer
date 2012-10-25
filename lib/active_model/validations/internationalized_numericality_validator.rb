require 'active_model/validations'

# ActiveModel Rails module.
module ActiveModel
  
  # ActiveModel::Validations Rails module. Contains all the default validators.
  module Validations

    class InternationalizedNumericalityValidator < ActiveModel::EachValidator
      def validate_each(record, attr_name, value)
        
        before_normalize = "#{attr_name}_before_normalize"
        before_type_cast = "#{attr_name}_before_type_cast"

        raw_value = record.send(before_normalize) if record.respond_to?(before_normalize.to_sym)
        raw_value ||= record.send(before_type_cast) if record.respond_to?(before_type_cast.to_sym)
        raw_value ||= value

        return if options[:allow_nil] && raw_value.nil?
        return unless raw_value.is_a?(String)

        # Not sure if it works with all types of internationalization
        separator = I18n.t('number.format.separator')
        delimiter = I18n.t('number.format.delimiter')

        unless raw_value =~ /^-?(\d+|\d{1,3}(#{delimiter}\d{3})*)(#{separator}\d+)?#{options[:percentage] ? "%?" : ""}$/
          record.errors.add(attr_name, :not_a_number)
        end
      end
    end

  end

end