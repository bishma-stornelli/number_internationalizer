module NumberInternationalizer
  module Helpers
    module InternationalizedNumberHelper
      
      include ActionView::Helpers::NumberHelper
      
      def display_as_number(number, options = {})
        return number unless number.is_a?(Numeric) || number.is_a?(String)
        options = { precision: 2 }.merge(options)
        number_with_precision(number,options)
      end
      
      def display_as_percentage(number, options = {})
        return number unless number.is_a?(Numeric)
        options = { precision: 2 }.merge(options)
        number_to_percentage(number * 100,options)
      end
    end
  end
end

ActionView::Base.send :include, NumberInternationalizer::Helpers::InternationalizedNumberHelper
ActiveRecord::Base.send :include, NumberInternationalizer::Helpers::InternationalizedNumberHelper