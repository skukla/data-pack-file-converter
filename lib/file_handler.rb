# lib/file_handler.rb
require 'csv'

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

  def self.write_file(output_data, output_file_path, input_format)
    if input_format == :json
      # Convert JSON data to CSV format before writing
      csv_data = json_to_csv(output_data)
    else
      csv_data = output_data
    end

    # Debug output to inspect CSV data
    puts "CSV data before writing to file:"
    puts csv_data.inspect

    # Write CSV data to file
    CSV.open(output_file_path, 'w') do |csv|
      csv_data.each do |row|
        csv << row
      end
    end
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

  private

  def self.json_to_csv(json_data)
    # Convert JSON data to CSV format
    csv_data = CSV.generate do |csv|
      json_hash = JSON.parse(json_data)
      json_hash.each do |key, value|
        csv << [key, value]
      end
    end

    # Debug output to inspect CSV data
    puts "CSV data after conversion from JSON:"
    puts csv_data.inspect

    csv_data
  end
end
