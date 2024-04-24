require 'pathname'

require_relative 'converters/BaseConverter'
require_relative 'converters/SettingsConverter'
require_relative 'converters/StoresConverter'

class App
  def initialize(input_file)
    @app_root = Pathname.getwd.to_s
    @output_dir = File.join(@app_root,'output')
    @input_file = input_file
    @converter = nil
    @output_extension = get_output_extension
    @output_filename = create_output_filename
    @output_file_path = create_output_file_path
    @output_content = nil
  end

  def converter_map()
    [
      { file: 'settings', class: SettingsConverter.new(@input_file) },
      { file: 'stores', class: StoresConverter.new(@input_file) },
    ]
  end
  
  def load_converter()
    converter = converter_map.select { |converter| converter[:file] == @input_file.type }.first
    
    abort("No converter for the given file type!") if converter.nil?
    
    @converter = converter[:class]
  end

  def parse_input()    
    case @input_file.extension
    when '.csv'
      @output_content = @converter.parse_csv(@input_file.content)
    when '.json'
      @output_content = @converter.parse_json(@input_file.content)
    end
  end

  def convert_input()    
    case @input_file.extension
    when '.csv'
      @output_content = @converter.convert_to_json(@output_content)
    when '.json'
      @output_content = @converter.convert_to_csv(@output_content)
    end
  end

  def write_ouput()    
    
    output_file = FileHandler.new(@output_file_path, @output_extension)

    puts "Writing #{@output_filename}..."
    
    output_file.write(@output_content)
  end

  private

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

  public

  def run
    create_output_dir
    load_converter
    parse_input
    convert_input
    write_ouput
  end
end