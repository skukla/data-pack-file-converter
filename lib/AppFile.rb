# AppFile.rb

require 'csv'
require_relative './FileHandler.rb'


class AppFile
  attr_reader :path, :filename, :extension, :type, :content

  def initialize(file_path)
    @path = file_path
    @filename = File.basename(@path)
    @extension = File.extname(@path)
    @type = File.basename(@filename, ".*")
    @content = FileHandler.new(@path, @extension).read
  end
end