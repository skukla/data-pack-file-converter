require 'pathname'
require_relative 'converters/SettingsConverter'


class App
  attr_reader :input_file, :converter, :output_dir

  def initialize(input_file)
    @app_root = Pathname.getwd.to_s
    @output_dir = File.join(@app_root,'output')
    @input_file = input_file
    @converter = nil
  end

  def converter_map()
    [
      { file: 'settings', class: SettingsConverter }
    ]
  end
  
  def load_converter()
    converter = converter_map.select { |converter| converter[:file] == @input_file.type }.first
    abort("No converter for the given file type!") if converter.nil?
    @converter = converter[:class].new(@input_file)
  end
end