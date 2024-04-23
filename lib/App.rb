require 'pathname'

class App
  attr_reader :input_file

  def initialize(input_file)
    @app_root = Pathname.getwd.to_s
    @output_dir = File.join(@app_root,'output')
    @input_file = input_file
  end

  private

  def create_output()
    Dir.mkdir(@output_dir) unless Dir.exist?(@output_dir)
  end
  
  public

  def run
    create_output
    pp @input_file
  end
end