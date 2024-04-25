# lib/converters/BaseConverter.rb
class BaseConverter
  attr_reader :data
  
  def initialize(file)
    @file = file
    @data = file.content
  end

  def convert_to_csv()
    @data = {
      headers: set_headers,
      rows: @data
    }
  end
end
