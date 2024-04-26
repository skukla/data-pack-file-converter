# lib/converters/StoresConverter.rb
class StoresConverter < BaseConverter
  def initialize(file)
    @data = file.content
  end

  def data_key
    "storeConfig"
  end

  def csv_to_hash      
    keys = @data[0]
    values = @data[1]
    
    hash_from_array = {}
    
    keys.each_with_index do |key, index|
      hash_from_array[key] = values[index]
    end
    
    @data = convert_int_and_bool(hash_from_array)
  end

  def convert_csv_to_json()
    csv_to_hash
    build_json
  end

  def convert_json_to_csv()
    string_to_json
    extract_json_body
    build_csv
  end
end
