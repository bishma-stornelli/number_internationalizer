module NumberInternationalizer
  
    def internationalize_number(*attributes)
      attributes.each do |attribute|
        normalize_attribute attribute, with: :number
        validates attribute, internationalized_numericality: true
      end
    end
    alias :internationalize_numbers :internationalize_number

end

ActiveRecord::Base.send :extend, NumberInternationalizer