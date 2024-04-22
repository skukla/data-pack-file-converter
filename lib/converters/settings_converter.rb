# lib/converters/settings_converter.rb
require 'csv'
require 'json'
require_relative 'base_converter'

class SettingsConverter < BaseConverter
  def parse_csv(csv_data)
    json_data = {}

    csv_data.each_line.with_index do |line, index|
      next if index == 0

      next if line.strip.empty?

      columns = line.strip.split(',')
      name = columns[0]
      value = columns[1]
      next if name.nil? || value.nil?

      json_data[name.strip] = value.strip
    end

    json_data
  end
end
