# lib/converters/BaseConverter.rb
class BaseConverter
  def initialize(file)
    @file = file
  end
  
  def parse_csv(csv_data)
    csv_data.shift # Remove headers
    csv_data.to_h.to_json
  end
  
  def parse_json(json_data)
    get_json_data(json_data).map { |key, value| [key.to_s, value.to_s] }
  end

  def convert_to_json(parsed_data)
    json_data = JSON.parse(parsed_data)
    JSON.pretty_generate(json_data)
  end
  
  def convert_to_csv(parsed_data)
    {
      headers: %w[name value],
      rows: parsed_data
    }
  end
end
