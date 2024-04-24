# lib/converters/StoresConverter.rb
class StoresConverter < BaseConverter
  def initialize(file)
    super
  end
  
  def get_json_data(json_data)
    JSON.parse(json_data)['data']['storeConfig']
  end
end
