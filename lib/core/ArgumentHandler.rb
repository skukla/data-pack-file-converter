# ArgumentHandler.rb
class ArgumentHandler
  def initialize(args)
    @args = args
  end
  
  def parse_arguments
    if @args.empty?
      puts "Usage: ruby your_script.rb <file_path_or_directory_path>"
      exit 1
    end
    
    @args.first
  end
end