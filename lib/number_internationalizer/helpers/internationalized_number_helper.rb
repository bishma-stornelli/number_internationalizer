module NumberInternationalizer
  module Helpers
    module InternationalizedNumberHelper
      
      include ActionView::Helpers::NumberHelper
      
      def display_as_number(number, options = {})
        return number unless number.is_a?(Numeric) || number.is_a?(String)
        options = { precision: 2 }.merge(options)
        number_with_precision(number,options)
      end
    end
  end
end

ActionView::Base.send :include, NumberInternationalizer::Helpers::InternationalizedNumberHelper