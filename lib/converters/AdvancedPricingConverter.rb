require_relative '../../utils/ProductAttributeCsvUtility'

# lib/converters/AdvancedPricingConverter.rb
class  AdvancedPricingConverter < BaseConverter
  include ProductAttributeCsvUtility
  
  def initialize(file)
    @data = file.content
    @extension = file.extension
    @headers = []
    @values = []
  end

  def data_key
    "advancedPricingExport"
  end

  def add_data_shell(data)
    @data = { 
      "data": { 
        "#{data_key}": "#{data}"
      }
    }
  end

  def csv_to_hash()
    @data = @data.each_with_object([]) do |row, arr|
      arr << convert_to_csv_string(row)
    end
  end

  def build_json
    json_data = add_data_shell(@data)
    @data = JSON.pretty_generate(json_data)
  end

  def extract_json_body
    @data = @data["data"][data_key]["data"]
    @data = convert_from_csv_string(@data) if @data.is_a?(String)
    @data
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
