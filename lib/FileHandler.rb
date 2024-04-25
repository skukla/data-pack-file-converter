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

  def is_multi_row?(data)
    return true if data.all? { |element| element.is_a?(Array) }

    return false if data.is_a?(Array)    
    
    false
  end

  def write(content, headers = nil)
    case @extension
    when '.json'
      File.open(@path, 'w') do |file|
        file.write(content)
      end
    when '.csv'
      if is_multi_row?(content[:rows])
        CSV.open(@path, 'w') do |csv|
          csv << content[:headers]
          content[:rows].each do |row|
            csv << row
          end
        end
      else
        CSV.open(@path, 'w') do |csv|
          csv << content[:headers]
          csv << content[:rows]
        end
      end
    end
  end
end