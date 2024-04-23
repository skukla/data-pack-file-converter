# main.rb
require_relative 'lib/ArgumentHandler.rb'
require_relative 'lib/App'
require_relative 'lib/AppFile'

args = ArgumentHandler.new(ARGV).parse_arguments
input_file = AppFile.new(args)
app = App.new(input_file)

app.run

