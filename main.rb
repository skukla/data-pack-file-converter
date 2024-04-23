# main.rb
require_relative 'lib/argument_handler'
require_relative 'lib/error_handler'
require_relative 'lib/file_handler'
require_relative 'lib/data_mapper'
require_relative 'lib/output_printer'

class Converter
  def self.convert(file_path)
    FileHandler.create_output_directory

    input_format = FileHandler.get_file_format(file_path)
    puts "Input file format: #{input_format}" # Debug output to inspect input file format
    
    input_data = FileHandler.read_file(file_path)
    mapped_data = DataMapper.map_data(input_data, input_format, file_path)

    output_format = input_format == :json ? :csv : :json
    puts "Output file format: #{output_format}" # Debug output to inspect output file format
    
    output_file_path = FileHandler.get_output_file_path("#{File.basename(file_path, '.*')}.#{output_format}")

    FileHandler.write_file(mapped_data, output_file_path, input_format)
    OutputPrinter.print_success("Conversion successful. Output file: #{output_file_path}")
  end
end

file_path = ArgumentHandler.parse_arguments
Converter.convert(file_path)
