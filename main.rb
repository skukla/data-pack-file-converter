# main.rb
require_relative './utils/System'
require_relative 'lib/core/ScreenPrinter'
require_relative 'lib/core/ArgumentHandler.rb'
require_relative 'lib/core/App'
require_relative 'lib/core/InputFile'
require_relative 'lib/core/OutputFile'
require_relative 'lib/core/FileHandler'

System::clear_screen

args = ArgumentHandler.new(ARGV).parse_arguments
app = App.new()
app.load_input_files(args).each do |file_path|
  app.input_file = InputFile.new(file_path)
  
  if !app.input_file.content.nil? && app.load_converter
    data = app.get_data
    output_file = OutputFile.new(app.output_file, data)
    app.write_ouput(output_file)
  end
  
  if app.input_file.content.nil?
    ScreenPrinter.print_message("#{Colors::YELLOW}There isn't an input file for #{app.input_file.filename} -- skipping...#{Colors::RESET}")
    next
  end
  
end