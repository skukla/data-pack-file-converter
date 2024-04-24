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
end
