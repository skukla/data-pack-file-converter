# lib/converters/StoresConverter.rb
class StoresConverter < BaseConverter
  def initialize(file)
    super
  end
  
  def set_headers()
    @data.shift
  end

  def parse_csv()
    @data = @data.map {|row| [row.join(',')] }
  end

  def parse_json()
    @data = get_json_data.map { |key, value| [key.to_s, value.to_s] }
    @data = @data.transpose.map(&:flatten)
    @data = @data.map { |value| "\"#{value}\"" }.join(',')
  end
  
  def convert_to_json()
    keys = @data[0][0].split(',')
    
    @data.shift
    
    data_hash = @data.map do |values|
      values = values[0].split(',')
      Hash[keys.zip(values)]
    end.first

    data_hash = {"data": { "storeConfig":data_hash } }

    @data = JSON.pretty_generate(data_hash)
  end
  
  def get_json_data()
    JSON.parse(@data)['data']['storeConfig']
  end
end
