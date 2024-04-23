# AppFile.rb

require 'csv'
require_relative './FileHandler.rb'


class AppFile
  attr_reader :path, :filename, :extenson, :content

  def initialize(file_path)
    @path = file_path
    @filename = File.basename(@path)
    @extension = File.extname(@path)
    @content = FileHandler.new(@path, @extension).read
  end
end