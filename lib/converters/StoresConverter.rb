# lib/converters/StoresConverter.rb
class StoresConverter < BaseConverter
  def initialize(file)
    @data = file.content
    @extension = file.extension
  end

  def data_key
    "storeConfig"
  end

  def convert_csv_to_json()
    csv_to_hash
    build_json
  end

  def convert_json_to_csv()
    string_to_json
    extract_json_body
    build_csv
  end
end
