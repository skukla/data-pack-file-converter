# main.rb
require_relative 'lib/ArgumentHandler.rb'
require_relative 'lib/App'
require_relative 'lib/InputFile'
require_relative 'lib/OutputFile'
require_relative 'lib/FileHandler'

args = ArgumentHandler.new(ARGV).parse_arguments
app = App.new()
app.load_input_files(args).each do |file_path|
  app.input_file = InputFile.new(file_path)
  app.load_converter
  data = app.get_data
  output_file = OutputFile.new(app.output_file, data)
  app.write_ouput(output_file)
end

