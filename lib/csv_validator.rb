require 'csv'

class CsvValidator
  def self.valid?(csv_file_path)
    num_columns = nil
    CSV.foreach(csv_file_path) do |row|
      num_columns ||= row.size
      return false if row.size != num_columns || row.empty?
      return false if row.any? { |cell| contains_invalid_characters?(cell) }
    end
    true
  rescue CSV::MalformedCSVError
    false
  end

  private

  def self.contains_invalid_characters?(string)
    # Specify the characters that are not allowed in the CSV cells
    invalid_characters = /[^[:print:]\t\n]/

    # Check if the string contains any invalid characters
    !string.nil? && string.match?(invalid_characters)
  end
end
