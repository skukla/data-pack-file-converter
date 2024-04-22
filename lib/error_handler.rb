# lib/error_handler.rb
class ErrorHandler
  def self.handle_error(message)
    puts "Error: #{message}"
    exit(1)
  end
end