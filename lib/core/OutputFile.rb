# OutputFile.rb
require_relative './AppFile.rb'

class OutputFile < AppFile
  attr_accessor :content
  
  def initialize(file_path, data = nil)
    super
    @content = data
  end
end
