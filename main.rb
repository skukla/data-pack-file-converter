# main.rb
require_relative 'lib/option_handler'
require_relative 'lib/converters/settings_converter'
require_relative 'lib/converters/stores_converter'
require_relative 'lib/file_handler'

options = OptionHandler.parse_options
file_path = ARGV[0]

if file_path.nil?
  puts "Error: No file or directory provided."
  exit
end

converter = nil

# Determine the appropriate converter based on the file type or other criteria
if file_path.end_with?('.csv')
  if file_path.include?('settings')
    converter = SettingsConverter.new
  elsif file_path.include?('stores')
    converter = StoresConverter.new
  end
end

if converter.nil?
  puts "Error: No converter found for the provided file."
  exit
end

csv_data = FileHandler.read_file(file_path)

json_data = converter.convert_to_json(csv_data)

directory_path = File.dirname(file_path)

file_name = File.basename(file_path, '.*')

output_file_path = File.join(directory_path, "#{file_name}.json")

FileHandler.write_file(output_file_path, json_data)

puts "Created file in #{output_file_path}."
