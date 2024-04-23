class FileHandler
  def initialize(path, extension)
    @path = path
    @extension = extension
  end

  def read
    case @extension
    when '.json'
      File.read(@path)
    when '.csv'
      CSV.read(@path)
    end
  end
end