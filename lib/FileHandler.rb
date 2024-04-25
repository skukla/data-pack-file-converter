class FileHandler
  def initialize(path, extension, content = nil)
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

  def write(content, headers = nil)
    case @extension
    when '.json'
      File.open(@path, 'w') do |file|
        file.write(content)
      end
    when '.csv'
    CSV.open(@path, 'w') do |csv|
        csv << content[:headers]
        content[:rows].each do |row|
          csv << row
        end
      end
    end
  end
end