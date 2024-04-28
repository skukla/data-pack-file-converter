# DataUtility.rb
module DataUtility
  def convert_values
    convert_ints
    convert_bools_csv_to_json if @extension == ".csv"
    convert_bools_json_to_csv if @extension == ".json"
  end

  def convert_ints()
    @data.merge!(@data) { |key, value| Integer(value) rescue value }
  end

  def convert_bools_csv_to_json    
    @data.transform_values! do |value|
      if value.to_s == "true" || value.to_s == "Y"
        true
      elsif value.to_s == "false" || value.to_s == "N"
        false
      else
        value
      end
    end
  end
  
  def convert_bools_json_to_csv
    @data.transform_values! do |value|
      if value.to_s == "true"
        "Y"
      elsif value.to_s == "false"
        "N"
      else
        value
      end
    end
  end
end
