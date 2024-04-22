# lib/argument_handler.rb
class ArgumentHandler
  def self.parse_arguments
    if ARGV.length != 1
      ErrorHandler.handle_error("Usage: ruby main.rb <file_path>")
    end
    ARGV[0]
  end
end