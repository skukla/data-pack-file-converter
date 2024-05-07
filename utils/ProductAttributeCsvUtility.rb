# ProductAttributeCsvUtility.rb
module ProductAttributeCsvUtility
  def get_string_data
    @data["items"].map do |items|
      items.select do |key, value|
        value.is_a?(String)
      end
    end
  end

  def get_string_headers
    headers = get_string_data[0].keys
    @headers = @headers + headers
  end

  def get_string_values
    values = get_string_data.map { |row| row.values }
    @values = @values + values
  end

  def get_hash_data
    @data["items"].map do |items|
      items.select do |key, value|
        value.is_a?(Hash) && key != "attribute_options"
      end
    end
  end

  def get_hash_headers(key)
    headers = get_hash_data.map do |item|
      item["#{key}"].keys
    end.first
    
    @headers = @headers + headers
  end

  def get_hash_values(key)
    values = get_hash_data.map do |item|
      item["#{key}"].values
    end

    @values = @values.zip(values).map(&:flatten)
  end

  def get_option_data
    @data["items"].map do |items|
      items.select do |key, value|
        key == "attribute_options"
      end
    end
  end

  def get_option_headers
    headers = ["attribute_options"]
    @headers = @headers + headers
  end
  
  def get_option_values
    values = get_option_data.map do |hash|
      hash["attribute_options"].map do |option| 
        option["label"]
      end.join("\n")
    end

    @values = @values.zip(values).map(&:flatten)
  end

  def convert_to_csv_string(arr)
    arr.map { |v| v.nil? ? "" : "#{v.to_s.gsub('"', '""')}" }
  end

  def convert_from_csv_string(str)
    JSON.parse(str.gsub('\\\"', '"')).each { |row| row.map! { |v| v == "" ? nil : v } }
  end
end
