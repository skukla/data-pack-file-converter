require 'pathname'
require_relative '../converters/SettingsConverter'
require_relative '../converters/StoresConverter'
require_relative '../converters/ProductAttributes'
require_relative '../converters/CustomersConverter'
require_relative '../converters/CustomerAddressesConverter'

class App
  attr_reader :converter, :input_file_list, :output_dir
  attr_accessor :input_file

  def initialize()
    @app_root = Pathname.getwd.to_s
    @output_dir = File.join(@app_root,'data', 'output')
    @input_file = nil
    @output_file = nil
    @converter = nil

    create_app_dirs
  end

  def converter_map()
    [
      { file: 'settings', class: SettingsConverter },
      { file: 'stores', class: StoresConverter },
      { file: 'product_attributes', class: ProductAttributesConverter },
      { file: 'customers', class: CustomersConverter },
      { file: 'customer_addresses', class: CustomerAddressesConverter }
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
    
    if converter.nil?
      puts "There isn't a #{@input_file.type} converter in the converter map -- skipping #{@input_file.filename}..."
      
      return
    end

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

  def app_dir_name(path)
    path.split(File::SEPARATOR)[-2..-1].map { |res| File.basename(res) }.join(File::SEPARATOR)
  end
  
  def create_app_dirs()
    csv_dir = File.join(@app_root, 'data', 'output', 'csv')
    json_dir = File.join(@app_root, 'data', 'output', 'json')
    dirs = [@output_dir, csv_dir, json_dir]
    
    dirs.each do |path|
      if !Dir.exist?(path)
        print "Creating #{app_dir_name(path)} app directory..."
        Dir.mkdir(path) unless Dir.exist?(path)
        sleep 0.25
        puts "done."
      end
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
    @output_file = File.join(@output_dir, output_extension[1..-1], "#{@input_file.type}#{output_extension}")
  end

  def write_ouput(file)    
    handler = FileHandler.new(file.path, file.extension)
    
    puts "Writing #{file.filename}..."
    
    handler.write(file.content)
  end
end