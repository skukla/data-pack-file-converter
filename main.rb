# main.rb
require_relative 'lib/core/ArgumentHandler.rb'
require_relative 'lib/core/App'
require_relative 'lib/core/InputFile'
require_relative 'lib/core/OutputFile'
require_relative 'lib/core/FileHandler'

args = ArgumentHandler.new(ARGV).parse_arguments
app = App.new()
app.load_input_files(args).each do |file_path|
  app.input_file = InputFile.new(file_path)
  app.load_converter
  data = app.get_data
  puts data
  # output_file = OutputFile.new(app.output_file, data)
  # app.write_ouput(output_file)
end

