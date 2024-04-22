# lib/file_handler.rb
class FileHandler
  def self.get_file_format(file_path)
    file_extension = File.extname(file_path)
    case file_extension
    when ".json"
      :json
    when ".csv"
      :csv
    else
      ErrorHandler.handle_error("Unsupported file format. Only JSON and CSV files are supported.")
    end
  end

  def self.read_file(file_path)
    File.read(file_path)
  end

  def self.write_file(output_data, output_file_path)
    File.write(output_file_path, output_data)
  end
  
  def self.get_output_directory
    "output"
  end

  def self.create_output_directory
    Dir.mkdir(get_output_directory) unless Dir.exist?(get_output_directory)
  end

  def self.get_output_file_path(file_name)
    File.join(get_output_directory, file_name)
  end
end