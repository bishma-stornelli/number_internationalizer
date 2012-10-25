module NumberInternationalizer
  
  def internationalize_number(*attributes)
    attributes.each do |attribute|
      normalize_attribute attribute, with: :number
      validates attribute, internationalized_numericality: {allow_nil: true}
      
      define_method :"#{attribute}_denormalized" do
        display_as_number(send :"#{attribute}")
      end
    end
  end
  alias :internationalize_numbers :internationalize_number
  
  def internationalize_percentage(*attributes)
    attributes.each do |attribute|
      #puts send :methods
      raise ArgumentError, "'#{attribute}' is not a valid attribute for '#{self.class.name}'" unless send( :attribute_names ).include?(attribute.to_s)
      normalize_attribute attribute, with: :percentage
      validates attribute, internationalized_numericality: {allow_nil: true, percentage: true}
      before_save  do
        b_normalize = self.send "#{attribute}_before_normalize"
        attribute_value = self.send(attribute)
        unless attribute_value.nil? || b_normalize.nil? || !b_normalize.is_a?(String)
          self.send "#{attribute}=", (attribute_value / 100.0)
        end
      end
      define_method :"#{attribute}_denormalized" do
        attr_before_normalize = send( "#{attribute}_before_normalize")
        return attr_before_normalize unless attr_before_normalize.nil? || !attr_before_normalize.is_a?(String)
        display_as_percentage(send :"#{attribute}")
      end
    end
  end
  alias :internationalize_percentages :internationalize_percentage
  
end

ActiveRecord::Base.send :extend, NumberInternationalizer