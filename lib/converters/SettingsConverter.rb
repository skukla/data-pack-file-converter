require 'csv'
require 'json'

# lib/converters/SettingsConverter.rb
class SettingsConverter < BaseConverter
  def initialize(file)
    super
  end
  
  def get_json_data(json_data)
    JSON.parse(json_data)['data']['dataInstallerStoreSettings']
  end
end
