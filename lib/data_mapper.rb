# lib/data_mapper.rb
require 'json'
require 'csv'
require_relative 'csv_validator'

class DataMapper
  TEMPLATE_DIR = 'templates'

  def self.map_data(input_data, input_format, file_path)
    input_file_basename = File.basename(file_path)
    puts "Input file basename: #{input_file_basename}" # Debug output

    template_dir = input_format == :json ? 'csv' : 'json'
    template_extension = input_format == :json ? 'csv' : 'json'
    template_filename = "#{input_file_basename.chomp(File.extname(input_file_basename))}.#{template_extension}"
    puts "Template filename: #{template_filename}" # Debug output

    template_file_path = File.join(TEMPLATE_DIR, template_dir, template_filename)
    puts "Template file path: #{template_file_path}" # Debug output

    unless File.exist?(template_file_path)
      ErrorHandler.handle_error("Template file not found for '#{input_file_basename}'. Skipping.")
    end

    unless CsvValidator.valid?(template_file_path)
      ErrorHandler.handle_error("CSV template file '#{template_file_path}' is not valid. Skipping.")
    end

    template_format = template_extension.to_sym
    template_data = load_template(template_file_path, template_format)
    mapped_data = perform_mapping(input_data, template_data, template_format)

    mapped_data.to_json
  end

  private

  def self.find_template_file(input_json, input_format)
    input_file_basename = input_json.keys[0]

    # Determine the subdirectory based on the input format
    template_subdir = input_format == :json ? 'json' : 'csv'
    template_files = Dir.glob(File.join(TEMPLATE_DIR, template_subdir, "*.*"))

    puts "Template files found: #{template_files}" # Debug output

    template_filenames = template_files.map { |file| File.basename(file, ".*") }
    puts "Template filenames without extension: #{template_filenames}" # Debug output
    puts "Input file basename: #{input_file_basename}" # Debug output

    template_file_path = template_files.find { |file| File.basename(file, ".*") == input_file_basename }

    if template_file_path.nil?
      ErrorHandler.handle_error("Template file not found for '#{input_file_basename}'. Skipping.")
      return nil
    end

    template_file_path
  end


  def self.load_template(template_path, template_format)

    puts "Template format: #{template_format}"

    case template_format
    when :json
      JSON.parse(File.read(template_path))
    when :csv
      CSV.read(template_path, headers: true)
    end
  end


  def self.perform_mapping(input_data, template_data, template_format)
    case template_format
    when :json
      convert_json_to_csv(input_data, template_data)
    when :csv
      convert_csv_to_json(input_data, template_data)
    end
end

  def self.convert_json_to_csv(json_data, template_data)
    input_data = JSON.parse(json_data)
    puts "Template Data: #{template_data}" # Debug output

    csv_data = CSV.generate(write_headers: true) do |csv|
      template_data.each do |row|
        puts "Row Type: #{row.class}" # Debug output
        if row.is_a?(Hash)
          name = row['name']
          value = input_data.dig(*row['value'].split('.'))
          csv << [name, value]
        else
          # Handle the case when row is not a hash
          ErrorHandler.handle_error("Template data is not in the expected format. Skipping.")
        end
      end
    end

    csv_data
  end



  def self.convert_csv_to_json(csv_data, template_data)
    input_data = CSV.parse(csv_data, headers: true)

    output_data = {}
    template_data.each do |row|
      name = row['name']
      value = input_data[name]
      output_data.deep_merge!(parse_key_value(row['value'], value))
    end

    output_data.to_json
  end

  def self.parse_key_value(key, value)
    parts = key.split('.')
    return { parts.last => value } if parts.size == 1

    { parts.first => parse_key_value(parts[1..-1].join('.'), value) }
  end
end
