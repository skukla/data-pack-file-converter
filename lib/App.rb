require 'pathname'
require_relative 'converters/SettingsConverter'


class App
  attr_reader :input_file, :converter, :output_dir

  def initialize(input_file)
    @app_root = Pathname.getwd.to_s
    @input_file = input_file
    @output_dir = File.join(@app_root,'output')
    @output_file = output_file
    @converter = nil
  end

  def converter_map()
    [
      { file: 'settings', class: SettingsConverter }
    ]
  end
  
  def load_converter()
    converter = converter_map.select { |converter| converter[:file] == @input_file.type }.first
    abort("No converter for the given file type!") if converter.nil?
    @converter = converter[:class].new(@input_file)
  end

  def get_data()
    case @input_file.extension
    when '.csv'
      @converter.convert_csv_to_json
    when '.json'
      @converter.convert_json_to_csv
    end
  end

  def create_output_dir()
    Dir.mkdir(@output_dir) unless Dir.exist?(@output_dir)
  end

  def output_extension()
    case @input_file.extension
    when '.csv'
      '.json'
    when '.json'
      '.csv'
    end
  end
  
  def output_file()
    File.join(@output_dir, "#{@input_file.type}#{output_extension}")
  end

  def write_ouput(file)    
    handler = FileHandler.new(file.path, file.extension)

    puts "Writing #{file.filename}..."
    
    handler.write(file.content)
  end
end