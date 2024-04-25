# OutputFile.rb

require_relative './AppFile.rb'

class OutputFile < AppFile
  attr_accessor :content
  
  def initialize(file_path, content = nil)
    super
    @content = content
  end
end
