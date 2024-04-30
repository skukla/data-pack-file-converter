require_relative '../../utils/ProductAttributeCsvUtility'
require_relative '../../utils/ProductAttributeJsonUtility'

# lib/converters/ProductAttributesConverter.rb
class ProductAttributesConverter < BaseConverter
  include ProductAttributeCsvUtility
  include ProductAttributeJsonUtility
  
  def initialize(file)
    @data = file.content
    @extension = file.extension
    @headers = []
    @values = []
  end

  def data_key
    "customAttributeMetadata"
  end

  def add_data_shell(data)
    @data = { 
      "data": { 
        "#{data_key}": { 
          "items": data 
          } 
        } 
      }
  end

  def set_csv_headers
    get_string_headers
    get_option_headers
    get_hash_headers("storefront_properties")
    get_hash_headers("admin_properties")
    @headers
  end
  
  def set_csv_data
    get_string_values
    get_option_values
    get_hash_values("storefront_properties")
    get_hash_values("admin_properties")
    @values
  end

  def csv_to_hash
    array = []
    keys = @data[0]
    @data.shift

    @data.map do |row| 
      hash_from_array = {}
      keys.each_with_index do |key, index|
        hash_from_array[key] = row[index]
      end
      array << hash_from_array
    end
    
    @data = array
  end 

  def reshape_hashes
    hash = {}
    @data = @data.each_with_object([]) do |row, array|
      hash = add_string_values(row)
      hash = hash.merge(
        add_attribute_options_values(row), 
        add_inner_hash(row, "storefront_properties"),
        add_inner_hash(row, "admin_properties")
        )
      array << hash
    end
  end

  def convert_csv_to_json()
    csv_to_hash
    reshape_hashes
    build_json
  end

  def convert_json_to_csv()
    string_to_json
    extract_json_body
    build_csv
  end
end
