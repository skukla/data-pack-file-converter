require_relative '../../utils/ProductAttributeUtility'

# lib/converters/ProductAttributesConverter.rb
class ProductAttributesConverter < BaseConverter
  include ProductAttributeUtility
  
  def initialize(file)
    @data = file.content
    @extension = file.extension
    @headers = []
    @values = []
  end

  def data_key
    "customAttributeMetadata"
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
