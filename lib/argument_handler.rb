# lib/argument_handler.rb
class ArgumentHandler
  def self.parse_arguments
    if ARGV.length != 1
      ErrorHandler.handle_error("Usage: ruby main.rb <file_path>")
    end
    file_path = ARGV.first
    unless File.exist?(file_path)
      ErrorHandler.handle_error("File '#{file_path}' not found.")
    end
    file_path
  end
end