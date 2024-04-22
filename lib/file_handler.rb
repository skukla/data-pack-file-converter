# lib/file_handler.rb
class FileHandler
  def self.read_file(file_path)
     File.read(file_path)
  end

  def self.write_file(file_path, content)
    File.open(file_path, 'w') { |file| file.write(content) }
  end

  def self.file_extension(file_path)
    File.extname(file_path)
  end
end
