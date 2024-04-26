# InputFile.rb

require_relative './AppFile.rb'

class InputFile < AppFile
  attr_accessor :content
  
  def initialize(file_path)  
    super
    @content = content
  end

  def content
    return nil unless File.exist?(@path)
    
    FileHandler.new(@path, @extension).read
  end
end
