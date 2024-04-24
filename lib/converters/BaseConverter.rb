# lib/converters/BaseConverter.rb
class BaseConverter
  attr_reader :data
  
  def initialize(file)
    @file = file
    @data = file.content
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
    @data = JSON.pretty_generate(parsed_json)
  end
  
  def convert_to_csv()
    @data = {
      headers: set_headers,
      rows: @data
    }
  end
end
