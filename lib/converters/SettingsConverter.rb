require 'csv'
require 'json'

require_relative 'BaseConverter'

# lib/converters/SettingsConverter.rb
class SettingsConverter < BaseConverter
  def initialize(file)
    super
    @json_key = "dataInstallerStoreSettings"
  end

  def csv_headers
    @data.keys
  end

  def csv_data
    @data.values
  end
  
  def convert_csv_to_json()
    remove_csv_headers
    csv_to_hash
    build_json
  end

  def convert_json_to_csv()
    string_to_json
    extract_json_body
    build_csv
  end
end
