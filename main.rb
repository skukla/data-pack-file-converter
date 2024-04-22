# main.rb
require_relative 'lib/option_handler'
require_relative 'lib/converter'

options = OptionHandler.parse_options
file_path = ARGV[0]

if file_path.nil?
  puts "Error: No file or directory provided."
  exit
end

if File.directory?(file_path)
  Dir.glob("#{file_path}/*") do |file|
    # Process each file in the directory
  end
else
  # Process single file
end
