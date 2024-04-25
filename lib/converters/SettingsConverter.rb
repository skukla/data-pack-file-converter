require 'csv'
require 'json'

# lib/converters/SettingsConverter.rb
class SettingsConverter < BaseConverter
  def initialize(file)
    super
  end

  def set_headers()
    @data.shift # Remove headers
    %w[name value]
  end
  
  def get_json_data()
    JSON.parse(@data)['data']['dataInstallerStoreSettings']
  end

  def parse_csv()
    set_headers
    @data = @data.to_h.to_json
  end
  
  def parse_json()
    @data = get_json_data.map { |key, value| [key.to_s, value.to_s] }
  end

  def convert_to_json()
    parsed_json = JSON.parse(@data)
    @data = {"data": { "dataInstallerStoreSettings":parsed_json } }
    @data = JSON.pretty_generate(@data)
  end
end
