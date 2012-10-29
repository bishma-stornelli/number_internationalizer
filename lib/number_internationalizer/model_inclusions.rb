module NumberInternationalizer
  
  def internationalize_number(*attributes)
    options = {allow_nil: true, 
      percentage: false}
    options = options.merge(attributes.pop) if attributes.last.is_a?(Hash)
    
    normalizer = options[:percentage] ? :percentage : :number
    
    attributes.each do |attribute|
      normalize_attribute attribute, with: normalizer
      validates attribute, internationalized_numericality: options
      
      add_before_save_callback(attribute) if options[:percentage]
      
      define_method :"#{attribute}_denormalized" do
        attr_before_normalize = send( "#{attribute}_before_normalize")
        return attr_before_normalize unless attr_before_normalize.nil? || !attr_before_normalize.is_a?(String)
        eval(%Q{display_as_#{normalizer}(send :"#{attribute}")})
      end
    end
  end
  alias :internationalize_numbers :internationalize_number
  
  private
  
  def add_before_save_callback(attribute)
    before_save  do
      b_normalize = self.send "#{attribute}_before_normalize"
      attribute_value = self.send(attribute)
      unless attribute_value.nil? || b_normalize.nil? || !b_normalize.is_a?(String)
        self.send "#{attribute}=", (attribute_value / 100.0)
      end
    end
  end
  
end

ActiveRecord::Base.send :extend, NumberInternationalizer