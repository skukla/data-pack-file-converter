# AppFile.rb
require 'csv'
require_relative './FileHandler.rb'


class AppFile
  attr_reader :path, :filename, :extension, :type

  def initialize(file_path, content = nil)
    @path = file_path
    @filename = File.basename(@path)
    @extension = File.extname(@path)
    @type = File.basename(@filename, ".*")
  end
end