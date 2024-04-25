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
app.create_output_dir
data = app.get_data
output_file = OutputFile.new(app.output_file, data)
app.write_ouput(output_file)