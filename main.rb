# main.rb
require_relative 'lib/ArgumentHandler.rb'
require_relative 'lib/App'
require_relative 'lib/InputFile'
require_relative 'lib/OutputFile'
require_relative 'lib/FileHandler'

args = ArgumentHandler.new(ARGV).parse_arguments
input_file = InputFile.new(args)
app = App.new(input_file)
app.load_converter
data = app.converter.convert_json_to_csv
output_file = OutputFile.new(File.join(app.output_dir, ".json"), data)

pp output_file