# lib/converters/base_converter.rb
class BaseConverter
  def parse_csv(csv_data)
    raise NotImplementedError, "Subclasses must implement the parse_csv method"
  end

  def convert_to_json(csv_data)
    json_data = parse_csv(csv_data)
    JSON.pretty_generate(data: json_data)
  end
end
