require 'csv'
require 'json'

# lib/converters/BaseConverter.rb
class BaseConverter  
  def initialize(file)
    @data = file.content
  end
  
  # CSV to JSON
  def remove_csv_headers
    @data.shift
    @data
  end

  def add_data_shell(data)
    @data = { "data": { "#{data_key}": data } }
  end

  def convert_int_and_bool(data)
    result = data.merge(data) { |key, value| Integer(value) rescue value }

    result.transform_values do |value|
      if value.to_s == 'true'
        true
      elsif value.to_s == 'false'
        false
      else
        value
      end
    end
  end

  def build_json
    json_data = add_data_shell(@data)
    @data = JSON.pretty_generate(json_data)
  end

  def csv_to_hash
    hash_from_array = {}

    @data.each do |inner_array|
      key = inner_array[0]
      value = inner_array[1]
      hash_from_array[key] = value
    end

    @data = convert_int_and_bool(hash_from_array)
  end

  # JSON to CSV
  def is_csv_single_row?
    return true if @data.is_a?(Array)    
    
    return false if @data.all? { |element| element.is_a?(Array) }

    false
  end

  def string_to_json
    @data = JSON.parse(@data).to_h
  end

  def extract_json_body
    @data = @data["data"][data_key]
  end

    def hash_to_csv    
    @data = @data.each_with_object([]) do |row, arr|
      arr << row
    end
  end

  def set_csv_headers(headers_arr = nil)  
    if @data.is_a?(Hash)
      return @data.keys if headers_arr.nil?
    end

    headers_arr
  end

  def set_csv_data
    if @data.is_a?(Hash)
      @data = [@data.values]
    end

    @data
  end

  def build_csv
    {
      headers: set_csv_headers,
      rows: set_csv_data
    }
  end
end