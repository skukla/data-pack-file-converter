require_relative '../../utils/CategoryJsonUtility'

# lib/converters/CategoriesConverter.rb
class CategoriesConverter < BaseConverter
  include CategoryJsonUtility
  
  def initialize(file)
    @data = file.content
    @extension = file.extension
  end

  def data_key
    "categories"
  end

  def add_data_shell(data)
    @data = { 
      "#{data_key}": { 
        "items": data 
        } 
      }
  end

  def set_csv_headers
    %w[name url_key path url_path is_active is_anchor include_in_menu position display_mode page_layout]
  end

  def extract_json_body
    @data = @data["data"][data_key]["items"].sort_by { |item| item["id"] }
  end

  def hash_to_csv
    @data = @data.map { |hash| hash.values }
  end

  def set_csv_data
    @data
  end

  def build_csv
    headers = set_csv_headers
    headers.delete('url_path')
    {
      headers: headers,
      rows: set_csv_data
    }
  end

  def convert_csv_to_json()
    nil
  end

  def convert_json_to_csv()
    string_to_json
    extract_json_body
    reshape_category_hashes
    hash_to_csv
    build_csv
  end
end
