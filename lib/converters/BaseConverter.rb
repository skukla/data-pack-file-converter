require 'csv'
require 'json'

# lib/converters/BaseConverter.rb
class BaseConverter
  def initialize(file)
    @data = file.content
  end

  # CSV to JSON
  def remove_csv_headers
    @data.shift
    @data
  end

  def csv_to_hash
    hash_from_array = {}

    @data.each do |inner_array|
      key = inner_array[0]
      value = inner_array[1]
      hash_from_array[key] = value
    end

    @data = hash_from_array
  end

  def hash_to_json
    @data = JSON.pretty_generate(@data)
  end

  # JSON to CSV
  def string_to_json
    @data = JSON.parse(@data).to_h
  end

  def extract_json_body
    @data = @data["data"][@json_key]
  end

  def build_csv
    [csv_headers, csv_data]
  end
end