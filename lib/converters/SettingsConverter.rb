require 'csv'
require 'json'

require_relative 'BaseConverter'

# lib/converters/SettingsConverter.rb
class SettingsConverter < BaseConverter  
  def initialize(file)
    super
  end

  def data_key
    "dataInstallerStoreSettings"
  end

  def set_csv_headers
    %w[name value]
  end
  
  def csv_to_hash
    hash_from_array = {}

    @data.each do |inner_array|
      key = inner_array[0]
      value = inner_array[1]
      hash_from_array[key] = value
    end

    @data = hash_from_array
  end
  
  def convert_csv_to_json()
    remove_csv_headers
    csv_to_hash
    build_json
  end

  def convert_json_to_csv()
    string_to_json
    extract_json_body
    hash_to_csv
    build_csv
  end
end
