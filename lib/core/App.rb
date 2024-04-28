require 'pathname'
require_relative '../converters/SettingsConverter'
require_relative '../converters/StoresConverter'
require_relative '../converters/ProductAttributes'

class App
  attr_reader :converter, :input_file_list, :output_dir
  attr_accessor :input_file

  def initialize()
    @app_root = Pathname.getwd.to_s
    @output_dir = File.join(@app_root,'data', 'output')
    @input_file = nil
    @output_file = nil
    @converter = nil

    create_output_dir
  end

  def converter_map()
    [
      { file: 'settings', class: SettingsConverter },
      { file: 'stores', class: StoresConverter },
      { file: 'product_attributes', class: ProductAttributesConverter }
    ]
  end

  def load_input_files(argument)
    if File.directory?(argument)
      Dir.glob(File.join(argument, "*"))
    else
      [argument]
    end
  end
  
  def load_converter()
    converter = converter_map.select { |converter| converter[:file] == @input_file.type }.first
    abort("There isn't a #{@input_file.type} converter in the converter map!") if converter.nil?
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
    if !Dir.exist?(@output_dir)
      print "Creating output directory..."
      Dir.mkdir(@output_dir) unless Dir.exist?(@output_dir)
      sleep 0.25
      puts "done."
    end
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
    @output_file = File.join(@output_dir, "#{@input_file.type}#{output_extension}")
  end

  def write_ouput(file)    
    handler = FileHandler.new(file.path, file.extension)
    
    puts "Writing #{file.filename}..."
    
    handler.write(file.content)
  end
end