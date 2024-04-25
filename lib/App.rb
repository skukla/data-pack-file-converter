require 'pathname'

require_relative 'converters/BaseConverter'
require_relative 'converters/SettingsConverter'
require_relative 'converters/StoresConverter'

class App
  attr_reader :input_file, :converter

  def initialize(input_file)
    @app_root = Pathname.getwd.to_s
    @output_dir = File.join(@app_root,'output')
    @input_file = input_file
    @converter = nil
    @output_extension = get_output_extension
    @output_filename = create_output_filename
    @output_file_path = create_output_file_path
  end

  def converter_map()
    [
      { file: 'settings', class: SettingsConverter },
      { file: 'stores', class: StoresConverter },
    ]
  end
  
  def load_converter()
    converter = converter_map.select { |converter| converter[:file] == @input_file.type }.first
    
    abort("No converter for the given file type!") if converter.nil?
    
    @converter = converter[:class].new(@input_file)
  end

  def parse_input()    
    case @input_file.extension
    when '.csv'
      @converter.parse_csv
    when '.json'
      @converter.parse_json
    end
  end

  def convert_input()    
    case @input_file.extension
    when '.csv'
      @converter.convert_to_json
    when '.json'
      @converter.convert_to_csv
    end
  end

  def write_ouput()    
    output_file = FileHandler.new(@output_file_path, @output_extension)

    puts "Writing #{@output_filename}..."

    output_file.write(@converter.data)
  end

  def create_output_dir()
    Dir.mkdir(@output_dir) unless Dir.exist?(@output_dir)
  end

  def get_output_extension()
    case @input_file.extension
    when '.csv'
      '.json'
    when '.json'
      '.csv'
    end
  end

  def create_output_filename()
    "#{@input_file.type}#{@output_extension}"
  end
  
  def create_output_file_path()
    File.join(@output_dir, @output_filename)
    
  end
end